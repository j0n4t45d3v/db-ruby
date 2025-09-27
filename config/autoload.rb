# frozen_string_literal: true

module Config
  ROOT_DIR = File.expand_path('../src', __dir__)
  ROOT_DIR.freeze
end

base_enum = File.join(Config::ROOT_DIR, 'enum')
autoload :Constraint, File.join(base_enum, 'constraint')
autoload :DataType, File.join(base_enum, 'data_type')

autoload :Core, File.join(Config::ROOT_DIR, 'core')

module Builder
  base_builder = File.join(Config::ROOT_DIR, 'builder')
  autoload :Record, File.join(base_builder, 'record')
  autoload :Table, File.join(base_builder, 'table')
end

module Model
  base_model = File.join(Config::ROOT_DIR, 'model')
  autoload :Where, File.join(base_model, 'where')
  autoload :Metadata, File.join(base_model, 'metadata')
  autoload :Field, File.join(base_model, 'metadata')
  autoload :Record, File.join(base_model, 'record')
  autoload :Table, File.join(base_model, 'table')
end
