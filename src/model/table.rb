# frozen_string_literal: true

module Model
  class Table
    # @!attribute name [r]
    #   @return [String]
    # @!attribute metadata [r]
    #   @return [Metadata]
    # @!attribute data [r]
    #   @return [Array<Record>]
    attr_reader :name, :metadata

    # @param name [String] table name
    # @param metadata [Metadata] table struct
    # @param data [Array<Record>] table records. default []
    def initialize(name:, metadata:, data: [])
      @name = name
      @metadata = metadata
      @data = data
    end

    # @param record [Record] new record to insert in table
    # @return [void]
    def insert(record:)
      record.valid_fields?
      @data << record
    end

    # @param where [Model::Where] new record to insert in table
    # @return [Array<Record>]
    def select(where:, fields: [:all])
      result = where.empty? ? @data : @data.filter { |record| where.match record }
      return result if fields.include? :all

      filter_fields data: result, fields: fields
    end

    # @return [Array<Field>]
    def fields
      @metadata.fields
    end

    # @return [Hash<String, Object>]
    def to_hash
      {
        metadata: @metadata.to_hash,
        data: @data.map(&:data_to_hash)
      }
    end

    private

    def filter_fields(data:, fields:)
      data.map do |record|
        values = record.fields.filter_map { |idx, field| record.values[idx] if fields.include? field.name }
        builder = Builder::Record.new table: self
        builder.fields(*fields)
               .values(*values)
      end
    end
  end
end
