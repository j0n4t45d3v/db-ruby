# frozen_string_literal: true

module Model
  class Condition
    attr_reader :field, :value, :type, :operator

    # @param field [String]
    # @param value [Object]
    # @param type [:and|:or]
    # @param operator [:equals|:like|:great_to|:less_to]
    def initialize(field:, value:, type:, operator: :equals)
      @field = field
      @value = value
      @type = type
      @operator = operator
    end
  end

  class Where
    # @!attribute conditions [r]
    #   @return [Array<Condition>]
    attr_reader :conditions

    def initialize
      @conditions = []
    end

    def and(field:, value:, operator: :equals)
      add_condition field: field, value: value, type: :and, operator: operator
    end

    def or(field:, value:, operator: :equals)
      add_condition field: field, value: value, type: :or, operator: operator
    end

    def empty?
      @conditions.empty?
    end

    # @param record [Record]
    # @return [true|false]
    def match(record)
      @conditions.all? do |filter|
        idx = record.fields.map(&:name).index filter.field
        unless idx.nil?
          if filter.operator == :equals
            record.values[idx] == filter.value
          else
            false
          end
        end
      end
    end

    private

    def add_condition(field:, value:, type:, operator:)
      @conditions << Condition.new(field: field, value: value, type: type, operator: operator)
      self
    end
  end
end
