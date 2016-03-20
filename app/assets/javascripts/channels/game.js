App.game = App.cable.subscriptions.create("GameChannel", {
  connected: function() {
    return setTimeout((function(_this) {
      return function() {
        _this.followCurrentGame();
        return _this.installPageChangeCallback();
      };
    })(this), 1000);
  },
  disconnected: function() {},
  received: function(data) {
    if (data["location"]) {
      window.location = data["location"];
    } else {
      var tr = $("tr#game_player_" + data["game_player_id"]);
      tr.replaceWith(data["game_player"]);
    }
  },
  accept: function(game_id) {
    return this.perform('accept', {
      game_id: game_id
    });
  },
  decline: function(game_id) {
    return this.perform('decline', {
      game_id: game_id
    });
  },
  start: function(game_id) {
    return this.perform('start', {
      game_id: game_id
    });
  },
  followCurrentGame: function() {
    var gameId;
    if (gameId = $('section#game').data('game-id')) {
      return this.perform('follow', {
        game_id: gameId
      });
    } else {
      return this.perform('unfollow');
    }
  },
  installPageChangeCallback: function() {
    if (!this.installedPageChangeCallback) {
      this.installedPageChangeCallback = true;
      return $(document).on('page:change', function() {
        return App.game.followCurrentGame();
      });
    }
  }
});

$(document).on('ready page:load', function () {
  var gameId = $('section#game').data('game-id');

  $(document).on('click', '[data-behavior=game_accept]', function(event) {
    App.game.accept(gameId);
  });

  $(document).on('click', '[data-behavior=game_decline]', function(event) {
    App.game.decline(gameId);
  });

  $(document).on('click', '[data-behavior=game_start]', function(event) {
    App.game.start(gameId);
  });
});
