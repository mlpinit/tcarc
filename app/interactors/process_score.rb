class ProcessScore
  
  attr_reader :meeples, :points

  def initialize(meeples:, points:)
    @meeples = meeples
    @points = points
  end

  def run
    game_players.each do |game_player|
      game_player.increment(:score, points)
      game_player.increment(:remaining_meeples, max_meeples)
    end
    meeples.update_all(archived: true) 
    true
  end

  private

  def groups
    @groups ||= meeples
      .group_by { |meeple| meeple.game_player }
      .map { |k,v| [k, v = v.count] }
      .to_h
  end

  def game_players
    @game_players ||= groups
      .select { |player,count| count == max_meeples }
      .keys
  end

  def max_meeples
    @max_meeples ||= groups.values.max
  end

end
