require 'player'
require 'spec_steps'

SpecSteps.define :create_player do |player_name|
  @players ||= []
  @players << Player.new(player_name)
end

SpecSteps.define :winner_beats_loser do |winner_name, loser_name|
  winner = @players.find { |player| player.name == winner_name }
  loser = @players.find { |player| player.name == loser_name }
  winner.beats(loser)
end

SpecSteps.define :player_has_played do |player_name, n|
  player = @players.find { |player| player.name == player_name }
  (player.wins + player.losses).should == n
end
