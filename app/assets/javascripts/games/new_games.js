$(document).on('ready page:load', function () {

  $("input#users_search").bind('input', function() {
    var ul = $("ul#users_search_results");
    ul.empty();
    var query = $(this).val();
    $.get("/users/search.json?query=" + query, function(data) {
      for (i = 0; i < data.length; i++) {
        var username = data[i][0];
        var userId = data[i][1];
        var userIdData = "data-user-id='" + userId + "'";
        var usernameData = "data-username='" + username + "'";
        var plus = "<span class='glyphicon glyphicon-plus pull-right add-game-player'></span>";
        var li_html = "<li class='form-control users_search' " + userIdData + " " + usernameData + ">" + username + plus + "</li>";
        ul.append(li_html);
      }
      addGamePlayer();
    });
  });

  function addGamePlayer() {
    $("span.add-game-player").click(function() {
      var element = $(this).parent();
      var userId = element.data("user-id");
      var username = element.data("username");
      var form = $("form#new_game");
      var game_players_list = $("div#game_players_list");
      var game_players = $("input.game_players_attributes");
      var count = game_players.length;

      var css_class = "class='game_players_attributes'"
      var value_and_type = "value='" + userId + "' type='hidden'"
      var name = "name='game[game_players_attributes]["+ count + "][user_id]'" 
      var css_id = "id='game_game_players_attributes_" + count + "_user_id'"

      var input = "<input " + css_class + " " + value_and_type + " " + name + " " + css_id + ">"
      var element = "<div>" + username + "</div>"

      form.append(input);
      if (gamePlayerNotPresent(username)) {
        game_players_list.append(element);
      }
    });
  }

  function gamePlayerNotPresent(username) {
    var bool = true;
    $("div#game_players_list").children().each(function() {
      var value = $(this).text();
      if (value === username) {
        bool = false;
      };
    });
    return bool;
  }

});
