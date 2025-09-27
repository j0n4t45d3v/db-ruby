# frozen_string_literal: true

require_relative 'config/autoload'

core = Core.new data: {}

new_table_builder = Builder::Table.new name: 'new_table'

new_table = new_table_builder
            .integer('id')
            .string('name')
            .build

record_builder = Builder::Record.new table: new_table
new_table.insert record: record_builder
  .fields('id', 'name')
  .values(2, 'John Doe')
  .build

new_table.insert record: record_builder
  .fields('id', 'name')
  .values(1, 'Mary')
  .build

new_table.insert record: record_builder
  .fields('id', 'name')
  .values(3, 'Luke')
  .build

core.create_table table: new_table

where = Model::Where.new
pp new_table.select(where: where).map(&:data_to_hash)
