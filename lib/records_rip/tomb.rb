require "records_rip/where_epitaph"

module RecordsRip
  class Tomb < ::ActiveRecord::Base
    class << self
      def where_epitaph(args = {})
        raise ArgumentError, "expected to receive a Hash" unless args.is_a?(Hash)
        WhereEpitaph.new(self, args).execute
      end
    end
  end
end
