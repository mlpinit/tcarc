class GameChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "game_channel_#{data['game_id']}"
  end

  def unfollow(data)
    stop_all_streams
  end

  def accept(data)
    current_user.game_players.find_by(game_id: data["game_id"]).accepted!
  end

  def decline(data)
    current_user.game_players.find_by(game_id: data["game_id"]).declined!
  end

end
