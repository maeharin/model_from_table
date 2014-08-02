class ModelFromTableGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_model_file
    ignore_table_names = %w(schema_migrations)

    resources = ActiveRecord::Base.connection.tables.map do |table_name|
      Resource.new ActiveRecord::Base.connection, table_name
    end

    resources.each do |resource|
      next if ignore_table_names.include? resource.table_name
      @resource = resource
      template "model.rb", resource.file_path
    end
  end

  class Resource
    attr_reader :table_name

    def initialize connection, table_name
      @connection = connection
      @table_name = table_name
    end

    def class_name
      @class_name ||= table_name.classify
    end

    def file_path
      "app/models/#{class_name.underscore}.rb"
    end

    def table_name_required?
      class_name.tableize != table_name
    end

    def primary_key_required?
      primary_key != nil && primary_key.to_s != 'id'
    end

    def primary_key
      @pk if @pk != nil

      if @connection.respond_to?(:pk_and_sequence_for)
        @pk, _ = @connection.pk_and_sequence_for(table_name)
      elsif @connection.respond_to?(:primary_key)
        @pk = @connection.primary_key(table_name)
      end

      @pk
    end

    def belongs_to_syms
      belongs_to_columns.map { |col| col.name.sub('_id', '').to_sym }
    end

    def belongs_to_columns
      @connection.columns(table_name).select { |col| col.name =~ /^.*_id$/ }
    end
  end
end
