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
    def insert(record:)
      record.valid_fields?
      @data << record
    end

    def fields
      @metadata.fields
    end

    # @return [Hash<String, Object>]
    def to_hash
      {
        metadata: @metadata,
        data: @data
      }
    end
  end
end
