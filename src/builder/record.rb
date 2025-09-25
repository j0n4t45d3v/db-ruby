# frozen_string_literal: true

module Builder
  class Record
    # @param table [Model::Table]
    def initialize(table:)
      @table = table
      @fields = @table.get_fields
      @values = []
    end

    # @param fields [Array<String>] list fields to insert
    # @return [Builder::Record]
    def fields(*fields)
      @fields = @table.get_fields.filter { |field| fields.include? field.name }
      self
    end

    # @param data [Array<Object>] list data fields to insert
    # @return [Builder::Record]
    def values(*data)
      @values = data
      self
    end

    # @return [Model::Record]
    def build
      Model::Record.new fields: @fields, values: @values
    end
  end
end
