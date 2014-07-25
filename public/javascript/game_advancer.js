var Render = function () {

  var $container;

  var init = function (container) {
    $container = $(container);
  };

  var render = function (gameData) {
    $container = $(".cell-container");

    $container.empty();

    gameData.forEach(function (row) {
      var $row;
      $row = $('<div class="row"></div>');
      row.forEach(function (col) {
        if (col === 1) {
          $row.append('<span class="cell selected">' + col + '</span>');
        } else {
          $row.append('<span class="cell">' + col + '</span>');
        }
      });
      $container.append($row);
    });
  };

  return {
    init: init,
    render: render
  }
};

var GameAdvancer = function () {

  var options;

  var init = function (opts) {
    options = opts;
  };

  var running;

  var start = function () {
    running = setInterval(function () {
      update();
    }, 1000);
  };

  var stop = function () {
    clearInterval(running);
  };

  var update = function () {
    var jqxhr = $.ajax({
      type: "POST",
      url: '/new',
      data: {},
      dataType: 'json',
      contentType: 'application/json'
    });

    jqxhr.done(function (gameData) {
      options.onUpdatedBoard(gameData);
    }.bind(this));

    jqxhr.fail(function (xhr) {
      console.log(xhr)
    }.bind(this));
  };

  return {
    init: init,
    start: start,
    stop: stop,
    update: update
  }
};