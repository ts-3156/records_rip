require "active_support/concern"

module RecordsRip
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def rest_in_place
        scope :tomb, -> { Tomb.where(item_type: self.class.to_s) }
      end
    end
  end
end
