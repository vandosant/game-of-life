require_relative 'grid_generator'

class GameOfLife
  attr_reader :cells

  def initialize(grid_size, starting_live_cells)
    @grid_size = grid_size
    @starting_live_cells = starting_live_cells
    @cells = []
  end

  def generate_cells
    @starting_live_cells.times do
      @cells << 1
    end

    (@grid_size - @starting_live_cells).times do
      @cells << 0
    end

    @cells.shuffle!
  end

  def advance
    if @cells.count(1) <= 2
      @cells.each_with_index do |cell, index|
        @cells[index] = 0 if cell == 1
      end
    else
      grid = get_grid
      x_max = grid.map { |coordinate| coordinate[0] }.sort.last
      dead_cell_indexes = []
      new_live_cell_indexes = []

      grid.each_with_index do |cell_coordinate, index|
        count = 0
        x_value = cell_coordinate[0]
        y_value = cell_coordinate[1]

        if x_value != 0 && @cells[index-1] == 1
          count += 1
        end

        if x_value != (x_max) && @cells[index+1] == 1
          count += 1
        end

        if grid.include?([0, y_value + 1]) && @cells[grid.index([x_value, (y_value + 1)])] == 1
          count += 1
        end

        if grid.include?([0, y_value - 1]) && @cells[grid.index([x_value, (y_value - 1)])] == 1
          count += 1
        end

        if count < 2 || count > 3
          dead_cell_indexes << index
        elsif count == 3
          new_live_cell_indexes << index
        end
      end

      dead_cell_indexes.each do |index|
        @cells[index] = 0
      end

      new_live_cell_indexes.each do |index|
        @cells[index] = 1
      end
    end
  end

  private

  def get_grid
    GridGenerator.map(@cells)
  end
end