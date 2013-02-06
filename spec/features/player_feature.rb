require 'support/steps/helper'

describe Player do
  before do
    SpecSteps.execute :create_player, 'James'
    SpecSteps.execute :create_player, 'Anthony'
    SpecSteps.execute :create_player, 'Chris'
  end

  it 'should track games played' do
    SpecSteps.execute :winner_beats_loser, 'James', 'Anthony'
    SpecSteps.execute :winner_beats_loser, 'James', 'Chris'
    SpecSteps.execute :winner_beats_loser, 'Anthony', 'James'

    SpecSteps.execute :player_has_played, 'James', 3
    SpecSteps.execute :player_has_played, 'Anthony', 2
    SpecSteps.execute :player_has_played, 'Chris', 1
  end
end