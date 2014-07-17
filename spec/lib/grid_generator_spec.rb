require 'spec_helper'
require './lib/grid_generator'

describe GridGenerator do
  it 'generates coordinates for an array' do
    input1 = [1, 0]

    grid1 = GridGenerator.map(input1, 1, 2)

    expected = [
      [0, 0],
      [1, 0]
    ]

    expect(grid1).to eq expected

    input2 = [1, 0]

    grid2 = GridGenerator.map(input2, 2, 1)

    expected = [
      [0, 0],
      [0, 1]
    ]

    expect(grid2).to eq expected
  end
end