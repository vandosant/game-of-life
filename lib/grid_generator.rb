class GridGenerator
  def self.map(items, items_per_row=nil)
    result = []
    x_count = 0
    y_count = 0

    while result.length < items.length
      result << [x_count, y_count]
      x_count += 1
      if items_per_row != nil && x_count >= items_per_row
        x_count = 0
        y_count += 1
      end
    end

    result
  end
end