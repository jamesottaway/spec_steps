class Player
  attr_accessor :name, :wins, :losses

  def initialize name
    self.name = name
    self.wins = 0
    self.losses = 0
  end

  def beats(loser)
    self.wins += 1
    loser.losses += 1
  end
end