require 'spec_helper'
require './lib/grid_generator'

describe GridGenerator do
  it 'generates coordinates for an array' do
    input = [1, 0]

    grid = GridGenerator.map(input)

    expected = [
      [0, 0],
      [1, 0]
    ]

    expect(grid).to eq expected
  end

  it 'generates rows based on parameters' do
    input = [1, 0]

    grid = GridGenerator.map(input, 1)

    expected = [
      [0, 0],
      [0, 1]
    ]

    expect(grid).to eq expected
  end
end