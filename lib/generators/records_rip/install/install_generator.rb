require "rails/generators"
require "rails/generators/active_record"

module RecordsRip
  class InstallGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    MYSQL_ADAPTERS = [
        "ActiveRecord::ConnectionAdapters::MysqlAdapter",
        "ActiveRecord::ConnectionAdapters::Mysql2Adapter"
    ].freeze

    source_root File.expand_path('templates', __dir__)

    desc "Generates (but does not run) a migration to add a tombs table."

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

    def create_migration_file
      add_records_rip_migration("create_tombs",
                                item_type_options: item_type_options,
                                tombs_table_options: tombs_table_options)
    end

    private

    def item_type_options
      opt = {null: false}
      opt[:limit] = 191 if mysql?
      ", #{opt}"
    end

    def mysql?
      MYSQL_ADAPTERS.include?(ActiveRecord::Base.connection.class.name)
    end

    def tombs_table_options
      if mysql?
        ', { options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" }'
      else
        ""
      end
    end

    def add_records_rip_migration(template, extra_options = {})
      migration_dir = File.expand_path("db/migrate")
      if self.class.migration_exists?(migration_dir, template)
        ::Kernel.warn "Migration already exists: #{template}"
      else
        migration_template(
            "#{template}.rb.erb",
            "db/migrate/#{template}.rb",
            {migration_version: migration_version}.merge(extra_options)
        )
      end
    end

    def migration_version
      major = ActiveRecord::VERSION::MAJOR
      if major >= 5
        "[#{major}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
