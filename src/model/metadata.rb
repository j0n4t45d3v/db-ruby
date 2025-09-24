# frozen_string_literal: true

module Model
  # @template T
  # @!attribute [r] name
  #   @return [String]
  # @!attribute [r] type
  #   @return [DataType::Type]
  # @!attribute [r] constraint
  #   @return [Constraint::Type]
  # @!attribute [r] not_null
  #   @return [Boolean]
  # @!attribute [r] default
  #   @return [T|nill]
  class Field
    attr_reader :name, :type, :constraint, :not_null, :default

    # @param name [String]  field name
    # @param type [DataType::Type] field type
    # @param constraint [Constraint::Type] field constraint
    # @param not_null [Boolean] if field is nullable
    # @param default [T|nil] field default value
    def initialize(name:, type:, constraint:, not_null:, default: nil)
      @name = name
      @type = type
      @constraint = constraint
      @not_null = not_null
      @default = default
    end

    def type_valid?(value)
      type.valid? value
    end

    # @return [Hash<String, Object>]
    def to_hash
      {
        type: @type,
        constraint: @constraint,
        not_null: @not_null,
        default: @default
      }
    end
  end

  # @!attribute [] fields
  #   @return [Array<Field>]
  class Metadata
    # @param fields [Array<Field>] list fields
    # @return [void]
    def initialize(fields:)
      @fields = fields
    end

    # @param fields [Array<String>] fields to use
    def filter_fields(fields:)
      @fields.filter { |field| fields.include? field.name }
    end

    # @return [Hash<String, Object>]
    def to_hash
      hash = {}
      @fields.each do |field|
        hash[field.name] = field.to_hash
      end
      hash
    end
  end
end
