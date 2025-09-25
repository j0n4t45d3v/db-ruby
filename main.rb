# frozen_string_literal: true

require_relative 'config/autoload'

core = Core.new data: {
  test: {
    metadata: {
      id: {
        type: 'integer',
        constraint: 'primary',
        not_null: true,
        default: 'increment'
      },
      name: {
        type: 'varchar|30',
        constraint: nil,
        not_null: false,
        default: nil
      }
    },
    data: [
      {
        id: 1,
        name: 'test 1'
      },
      {
        id: 2,
        name: 'teste 2'
      }
    ]
  }
}

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

core.create_table table: new_table

pp core.show_all
