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

# metadata_new_table = Model::Metadata.new fields: [
#   Model::Field.new(name: 'id', type: DataType::INTEGER, constraint: nil, not_null: true),
#   Model::Field.new(name: 'name', type: DataType::VARCHAR, constraint: nil, not_null: false)
# ]
#
# new_table = Model::Table.new name: 'new_table', metadata: metadata_new_table
#
# fields = metadata_new_table.filter_fields(fields: %w[id name])
# record = Model::Record.new(fields: fields, values: [1, 'test record'])

new_table_builder = Builder::Table.new name: 'new_table'

new_table = new_table_builder
  .integer('id')
  .string('name')
  .build

# new_table.insert record: record

core.create_table table: new_table

pp core.show_all
