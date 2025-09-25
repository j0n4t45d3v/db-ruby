# frozen_string_literal: true

module Model
  class Record
    attr_reader :fields, :values

    # @param fields [Array<Field>] list fields
    # @param values [Array<Object>] list value fields
    def initialize(fields:, values:)
      @fields = fields
      @values = values
    end

    def valid_fields?
      return false if @fields.length != @values.length

      valid_record = false
      @fields.each_with_index do |e, idx|
        valid_record = e.type_valid? @values[idx]
      end
      valid_record
    end

    def data_to_hash
      hash = {}
      @fields.each_with_index do |e, idx|
        hash[e.name] = @values[idx]
      end
      hash
    end
  end
end
