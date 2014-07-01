class GameOfLife
  attr_reader :grid

  def initialize(grid_size, starting_live_cells)
    @grid_size = grid_size
    @starting_live_cells = starting_live_cells
    @grid = []
  end

  def generate_grid
    @starting_live_cells.times do
      @grid << 1
    end

    (@grid_size - @starting_live_cells).times do
      @grid << 0
    end

    @grid.shuffle!
  end
end