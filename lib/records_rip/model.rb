require "active_support/concern"

module RecordsRip
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def rest_in_place
        model_class = self

        model_class.send(
            "before_destroy",
            lambda do |record|
              ::RecordsRip::Tomb.create(item_id: record.id, item_type: record.class.name, object: '{}')
            end
        )

        scope :tomb, -> {::RecordsRip::Tomb.where(item_type: model_class.to_s)}
      end
    end
  end
end
