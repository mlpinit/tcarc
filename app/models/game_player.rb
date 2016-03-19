class GamePlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :meeples, -> { where(archived: false) }
  has_one :next_game_player, class_name: "GamePlayer", foreign_key: :next_game_player_id
  has_many :tiles

  enum invite: { pending: 0, accepted: 1, declined: 2 }

  validates :game_id, uniqueness: { scope: :user_id }


  after_commit do 
  # TODO: move to jobs
    ActionCable.server.broadcast(
      "game_channel_#{self.game.id}",
      game_player: GamePlayersController.render(partial: "game_players/game_player", locals: { game_player: self }),
      game_player_id: self.id
    )
  end

  # TODO: move to presenter everything bellow here

  def invite_css_status
    case invite
    when "accepted"
      "success"
    when "declined"
      "danger"
    else
      "info"
    end
  end

end
