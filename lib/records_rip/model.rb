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
              epitaph = Hash[record.attributes.map {|k, v| [k, v]}]
              ::RecordsRip::Tomb.create(item_id: record.id, item_type: record.class.name, epitaph: epitaph)
            end
        )

        define_singleton_method 'tomb' do |args = {}|
          ::RecordsRip::Tomb.where(item_type: model_class.to_s).where_epitaph(args)
        end
      end
    end
  end
end
