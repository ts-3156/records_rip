require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# for debugging
ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV["DEBUG"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

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
