require_relative 'grid_generator'

class GameOfLife
  attr_reader :cells, :rows, :columns

  def initialize(cells, rows, columns)
    @cells = cells
    @rows = rows
    @columns = columns
  end

  def advance
    @grid = GridGenerator.map(@cells, @rows, @columns)
    x_max = @grid.map { |coordinate| coordinate[0] }.sort.last
    y_max = @grid.map { |coordinate| coordinate[1] }.sort.last
    dead_cell_indexes = []
    new_live_cell_indexes = []

    @grid.each_with_index do |cell_coordinate, index|
      live_neighbor_count = 0
      x_value = cell_coordinate[0]
      y_value = cell_coordinate[1]

      if left_neighbor_present?(x_value) && left_neighbor_alive?(index)
        live_neighbor_count += 1
      end

      if right_neighbor_present?(x_value, x_max) && right_neighbor_alive?(index)
        live_neighbor_count += 1
      end

      if top_neighbor_present?(y_value) && top_neighbor_alive?(x_value, y_value)
        live_neighbor_count += 1
      end

      if bottom_neighbor_present?(y_value, y_max) && bottom_neighbor_alive?(x_value, y_value)
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

  def left_neighbor_alive?(index)
    @cells[index-1] == 1
  end

  def right_neighbor_alive?(index)
    @cells[index+1] == 1
  end

  def top_neighbor_alive?(x_coordinate, y_coordinate)
    @cells[@grid.index([x_coordinate, (y_coordinate - 1)])] == 1
  end

  def bottom_neighbor_alive?(x_coordinate, y_coordinate)
    @cells[@grid.index([x_coordinate, (y_coordinate + 1)])] == 1
  end
end