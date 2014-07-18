class GameOfLife
  attr_reader :cells, :rows, :columns, :starting_matrix, :current_matrix

  def initialize(cells, rows, columns)
    @cells = cells
    @rows = rows
    @columns = columns

    @starting_matrix = GameOfLife.array_to_matrix cells, rows, columns
    @current_matrix = GameOfLife.array_to_matrix cells, rows, columns
    @next_matrix = GameOfLife.array_to_matrix cells, rows, columns
  end

  def self.array_to_matrix(cells, rows, cols)
    matrix = []
    (0...rows).each do |r|
      matrix << []
      (0...cols).each do |c|
        matrix[r] = [] unless matrix[r]
        matrix[r][c] = cells[(r*cols) + c]
      end
    end

    matrix
  end


  def live_neighbors(row, col)
    count = 0

    [
    [-1, -1],
    [-1, 0],
    [-1, 1],

    [0, -1],
    [0, 1],

    [1, -1],
    [1, 0],
    [1, 1],
    ].each do |offset|
      offset_row = row + offset[0]
      offset_col = col + offset[1]
      if offset_row >= 0 and offset_row < @rows and
        offset_col >= 0 and offset_col < @columns

        if @current_matrix[row + offset[0]][col+offset[1]] == 1
          count += 1
        end

      end
    end
    count
  end

  def advance
    (0...@rows).each do |r|
      (0...@columns).each do |c|
        live_neighbor_count = live_neighbors(r, c)
        if live_neighbor_count == 2 || live_neighbor_count == 3 && @current_matrix[r][c] == 1
          @next_matrix[r][c] = @current_matrix[r][c]
        elsif live_neighbor_count < 2 && @current_matrix[r][c] == 1
          @next_matrix[r][c] = 0
        elsif live_neighbor_count > 3 && @current_matrix[r][c] == 1
          @next_matrix[r][c] = 0
        elsif live_neighbor_count == 3 && @current_matrix[r][c] == 0
          @next_matrix[r][c] = 1
        end
      end
    end

    @current_matrix = @next_matrix
  end

  def to_s
    result = []
    @current_matrix.each do |row|
      result << row.join(' ')
    end
    result.join("\n")
  end
end
