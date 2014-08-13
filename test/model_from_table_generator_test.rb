require 'test_helper'
require 'generators/model_from_table_generator'

class ModelFromTableGeneratorTest < Rails::Generators::TestCase
  tests ModelFromTableGenerator
  destination File.expand_path("../tmp", __FILE__)
  setup :prepare_destination

  test "all files are created" do
    run_generator

    assert_file 'app/models/user.rb'
    assert_file 'app/models/company.rb'
    assert_file 'app/models/legacy_table.rb'
  end

  test "not create schema_migration.rb" do
    run_generator

    assert_no_file 'app/models/schema_migration.rb'
  end

  test "rails convension" do
    run_generator

    assert_file 'app/models/user.rb' do |content|
      assert_match /class User < ActiveRecord::Base/, content
      assert_match /end/, content
      assert_no_match /self.table_name/, content
      assert_no_match /self.primary_key/, content
    end
  end

  test "table_name is not rails convension" do
    run_generator

    assert_file 'app/models/company.rb' do |content|
      assert_match /class Company < ActiveRecord::Base/, content
      assert_match /self.table_name = "company"/, content
      assert_match /end/, content
      assert_no_match /self.primary_key/, content
    end
  end

  test "table_name and primary_key is not rails convension" do
    run_generator

    assert_file 'app/models/legacy_table.rb' do |content|
      assert_match /class LegacyTable < ActiveRecord::Base/, content
      assert_match /self.table_name = "legacy_table"/, content
      assert_match /self.primary_key = "code"/, content
      assert_match /end/, content
    end
  end

  test "set `belongs_to :foo` if table has `foo_id` column" do
    run_generator

    assert_file 'app/models/song.rb' do |content|
      assert_match /class Song < ActiveRecord::Base/, content
      assert_match /self.table_name = "song"/, content
      assert_match /self.primary_key = "song_code"/, content
      assert_match /belongs_to :user/, content
      assert_match /end/, content
    end
  end

  test "generate with parent option" do
    run_generator %w(--parent MyClass::Base)

    assert_file 'app/models/user.rb' do |content|
      assert_match /class User < MyClass::Base/, content
    end
  end
end
