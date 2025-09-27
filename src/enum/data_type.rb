# frozen_string_literal: true

module DataType
  Type = Struct.new(:name, :max_size) do
    def lentgh
      max_size
    end

    def display
      "#{name.to_s.capitalize}(#{max_size})"
    end

    # @param value [Object]
    # @return [Boolean]
    def valid?(value)
      case name
      when :VARCHAR
        value.is_a?(String) && value.length <= max_size
      when :INTEGER
        value.is_a?(Integer) && value <= max_size
      when :BOOL
        [true, false].include?(value)
      else
        false
      end
    end
  end

  # private_constant :Type

  VARCHAR = Type.new(:VARCHAR, 255)
  INTEGER = Type.new(:INTEGER, 100)
  BOOLEAN = Type.new(:BOOL, 1)

  VARCHAR.freeze
  INTEGER.freeze
  BOOLEAN.freeze
end
