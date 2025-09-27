# frozen_string_literal: true

class Core
  # @param data [Hash<Symbol, Model::Table>]
  def initialize(data:)
    @data = data
  end

  # @param table [Model::Table] table base model
  # @return [void]
  def create_table(table:)
    @data[table.name] = table
  end

  # @param from [String] table name
  # @param where [Hash] conditions
  # @param fields [Array] fields to show in result. default [:all]
  # @return [Array<Hash<String, Object>>]
  def select(from:, where: {}, field: [:all])
    data_filted = @data[from.to_sym][:data].select do |item|
      where.all? { |key, condition| item[key] == condition[:value] }
    end

    field.include?(:all) ? data_filted : data_filted.map { |record| record.slice(*field) }
  end

  # @param from [String] table name
  # @param data [Model::Record] data fields and values
  # @return [void]
  def insert(from:, data:)
    @data[from].insert record: data
  end

  def show_all
    @data.map { |key, value| [key, value.to_hash] }
  end
end
