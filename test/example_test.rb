# frozen_string_literal: true

class Example
  def self.sum(x:, y:)
    x + y
  end
end

RSpec.describe Example do
  it 'sum values' do
    value = Example.sum x: 1, y: 2
    expect(value).to eq(3)
  end
end
