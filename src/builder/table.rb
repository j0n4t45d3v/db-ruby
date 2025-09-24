# frozen_string_literal: true

module Builder
  # @!attribute fields []
  #   @return [Array<Model::Fields>]
  # @!attribute name []
  #   @return [String]
  class Table
    # @param name [String] table name
    def initialize(name:)
      @table_name = name
      @fields = []
    end

    # @param name [String] table name
    # @param constraint [Constraint::Type|nil]
    # @param nullable [Boolean]
    # @return [Table]
    def string(name, constraint: nil, nullable: false)
      add_field name, type: DataType::VARCHAR, constraint: constraint, nullable: nullable
    end

    # @param name [String] table name
    # @param constraint [Constraint::Type|nil]
    # @param nullable [Boolean]
    # @return [Table]
    def integer(name, constraint: nil, nullable: false)
      add_field name, type: DataType::INTEGER, constraint: constraint, nullable: nullable
    end

    # @param name [String] table name
    # @param constraint [Constraint::Type|nil]
    # @param nullable [Boolean]
    # @return [Table]
    def boolean(name, constraint: nil, nullable: false)
      add_field name, type: DataType::BOOLEAN, constraint: constraint, nullable: nullable
    end

    # @param name [String] table name
    # @param type [DataType::Type|nil]
    # @param constraint [Constraint::Type|nil]
    # @param nullable [Boolean]
    # @return [Table]
    def add_field(name, type: DataType::VARCHAR, constraint: nil, nullable: false)
      @fields << Model::Field.new(
        name: name,
        type: type,
        constraint: constraint,
        not_null: nullable
      )
      self
    end

    # @return [Model::Table]
    def build
      metadata = Model::Metadata.new fields: @fields
      Model::Table.new name: @table_name, metadata: metadata
    end
  end
end
