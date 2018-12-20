module RecordsRip
  class WhereEpitaph
    def initialize(tomb_model_class, attributes)
      @tomb_model_class = tomb_model_class
      @attributes = attributes
    end

    def execute
      column = @tomb_model_class.columns_hash["epitaph"]
      raise "where_epitaph can't be called without an epitaph column" unless column

      case column.type
      when :jsonb
        jsonb
      when :json
        json
      else
        text
      end
    end

    private

    def json
      predicates = []
      values = []
      @attributes.each do |field, value|
        predicates.push "epitaph->>? = ?"
        values.concat([field, value.to_s])
      end
      sql = predicates.join(" and ")
      @tomb_model_class.where(sql, *values)
    end

    def jsonb
      @tomb_model_class.where("epitaph @> ?", @attributes.to_json)
    end

    def text
      arel_field = @tomb_model_class.arel_table[:epitaph]
      where_conditions = @attributes.map { |field, value|
        where_epitaph_condition(arel_field, field, value)
      }
      where_conditions = where_conditions.reduce { |a, e| a.and(e) }
      @tomb_model_class.where(where_conditions)
    end

    def where_epitaph_condition(arel_field, field, value)
      arel_field.matches(%Q(%"#{field}"=>"#{value}"%)).or(arel_field.matches(%Q(%"#{field}"=>#{value}%)))
    end
  end
end
