window.GridMaker = {
  initialize: function () {
// listen to rows, columns
    var $rows = $('#rows');
    var $cols = $('#columns');

    var doKeyUp = function () {
      generateGrid($rows.val(), $cols.val());
    };

    $rows.keyup(doKeyUp);
    $cols.keyup(doKeyUp);

// generate a grid
    var generateGrid = function (rows, cols) {
      var $container = $('#container');

      $container.empty();

      rows = parseInt(rows);
      cols = parseInt(cols);
      for (var r = 0; r < rows; r++) {
        var $row;
        $row = $('<div class="row"></div>');

        for (var c = 0; c < cols; c++) {
          $row.append('<span class="cell">0</span>');
        }

        $container.append($row);
      }

      GridMaker.updateBoard($container);
    };

    $(document).on("click", "span.cell", function ($container) {

      $(this).toggleClass('selected');

      if ($(this).text() == '0') {
        $(this).text('1');
      } else {
        $(this).text('0');
      }

      GridMaker.updateBoard($container);
    });
  },
  updateBoard: function () {
    var cells = [];
    var value = null;
    $("span.cell").each(function () {
      cellValue = $(this).text();
      cells.push(cellValue);
    });

    $("#board").val(cells);
  }
};