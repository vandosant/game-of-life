class GridGenerator
  def self.map(items, rows, columns)
    result = []
    x_count = 0
    y_count = 0

    items.length.times do
      result << [x_count, y_count]
      x_count += 1
      if x_count >= columns
        x_count = 0
        y_count += 1
      end
    end

    result
  end
end