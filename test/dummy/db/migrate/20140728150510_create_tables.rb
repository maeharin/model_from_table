class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :company do |t|
      t.string :name
    end

    create_table :legacy_table, id: false do |t|
      t.primary_key:code
      t.string :name
    end
  end
end
