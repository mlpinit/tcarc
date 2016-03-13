$(document).on('ready page:load', function () {

  $("input#users_search").bind('input', function() {
    var ul = $("ul#users_search_results");
    ul.empty();
    var query = $(this).val();
    $.get("/users/search.json?query=" + query, function(data) {
      var username, userId, usernameData, plus, li_html;
      for (i = 0; i < data.length; i++) {
        username = data[i][0];
        userId = data[i][1];
        userIdData = "data-user-id='" + userId + "'";
        usernameData = "data-username='" + username + "'";
        plus = "<span class='glyphicon glyphicon-plus pull-right add-game-player'></span>";
        li_html = "<li class='form-control users_search' " + userIdData + " " + usernameData + ">" + username + plus + "</li>";
        ul.append(li_html);
      }
      addGamePlayer();
    });
  });

  var addGamePlayer = function () {
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

      if (gamePlayerNotPresent(username)) {
        form.append(input);
        game_players_list.append(element);
      }
    });
  }

  var gamePlayerNotPresent = function (username) {
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
