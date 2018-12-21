require "active_support/concern"

module RecordsRip
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def rest_in_place(&block)
        model_class = self

        serializer =
            if block_given?
              block
            else
              lambda do |record|
                Hash[record.attributes.map {|k, v| [k, v]}]
              end
            end

        model_class.send(
            "before_destroy",
            lambda do |record|
              epitaph = serializer.call(record)
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
