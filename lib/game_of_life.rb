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
    grid = get_grid
    x_max = grid.map { |coordinate| coordinate[0] }.sort.last
    y_max = grid.map { |coordinate| coordinate[1] }.sort.last
    dead_cell_indexes = []
    new_live_cell_indexes = []

    grid.each_with_index do |cell_coordinate, index|
      live_neighbor_count = 0
      x_value = cell_coordinate[0]
      y_value = cell_coordinate[1]

      if left_neighbor_present?(x_value) && @cells[index-1] == 1
        live_neighbor_count += 1
      end

      if right_neighbor_present?(x_value, x_max) && @cells[index+1] == 1
        live_neighbor_count += 1
      end

      if bottom_neighbor_present?(y_value, y_max) && @cells[grid.index([x_value, (y_value + 1)])] == 1
        live_neighbor_count += 1
      end

      if top_neighbor_present?(y_value) && @cells[grid.index([x_value, (y_value - 1)])] == 1
        live_neighbor_count += 1
      end

      if live_neighbor_count < 2 || live_neighbor_count > 3
        dead_cell_indexes << index
      elsif live_neighbor_count == 3
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

private

def get_grid
  GridGenerator.map(@cells)
end

def left_neighbor_present?(x_coordinate)
  x_coordinate != 0
end

def right_neighbor_present?(x_coordinate, x_max)
  x_coordinate != x_max
end

def top_neighbor_present?(y_coordinate)
  y_coordinate != 0
end

def bottom_neighbor_present?(y_coordinate, y_max)
  y_coordinate != y_max
end

end