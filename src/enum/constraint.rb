# frozen_string_literal: true

module Constraint
  Type = Struct.new(:name) do
    def self.display
      name.to_s
    end
  end

  # private_constant :Type

  PRIMARY_KEY = Type.new(:PRIMARY_KEY)
  FOREIGHT_KEY = Type.new(:FOREIGHT_KEY)
  UNIQUE = Type.new(:UNIQUE)
  CHECK = Type.new(:CHECK)

  PRIMARY_KEY.freeze
  FOREIGHT_KEY.freeze
  UNIQUE.freeze
  CHECK.freeze
end
