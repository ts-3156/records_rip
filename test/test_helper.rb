require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# for debugging
ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV["DEBUG"]

# migrations
ActiveRecord::Base.establish_connection(YAML.load_file("test/database.#{ENV['DB']}.yml")["test"])

ActiveRecord::Migration.create_table :tombs do |t|
  t.string :item_type
  t.integer :item_id, null: false
  t.text :epitaph, limit: 1024
end

class ::RecordsRip::Tomb < ActiveRecord::Base
end

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
end

class User < ActiveRecord::Base
  rest_in_place
end

ActiveRecord::Migration.create_table :members do |t|
  t.string :name
end

class Member < ActiveRecord::Base
  rest_in_place {|record| Hash[record.attributes.map {|k, v| [k, "Great #{v}"]}]}
end
