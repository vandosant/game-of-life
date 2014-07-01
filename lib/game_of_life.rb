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
end