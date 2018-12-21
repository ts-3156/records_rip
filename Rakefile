require "bundler/gem_tasks"
require "rake/testtask"

ENV["DB"] ||= "sqlite"

database = 'records_rip_test'

task :clean do
  case ENV["DB"]
  when "mysql"
    system("mysqladmin drop -f #{database} > /dev/null 2>&1")
  when "postgres"
    system("dropdb --if-exists #{database} > /dev/null 2>&1")
  when nil, "sqlite"
    nil
  else
    raise "Don't know how to clean specified RDBMS: #{ENV['DB']}"
  end
end

task prepare: [:clean] do
  case ENV["DB"]
  when "mysql"
    system("mysqladmin create #{database}")
  when "postgres"
    system("createdb #{database}")
  when nil, "sqlite"
    nil
  else
    raise "Don't know how to create specified DB: #{ENV['DB']}"
  end
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: %i[prepare test]
