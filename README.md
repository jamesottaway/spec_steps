spec_steps
==========

A library for writing reusable steps for use in specifications.

### About

Cucumber is a great tool for writing and running specifications, but we nearly always have RSpec available in the project, so why do we need Cucumber when we can make RSpec perform the same job?

RSpec's spec files are equivalent to Cucumber's feature files, but RSpec is missing the step definition abstraction, which is a gap this library aims to bridge.

### Example

First we need a class to start testing: `lib/player.rb`

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

Next we want some steps to help us articulate the functionality of the `Player` class: `spec/support/steps/player_steps.rb`

    require 'spec_steps'

    step "a player named :player_name exists" do |player_name|
      @players ||= []
      @players << Player.new(player_name)
    end

    step ":winner_name beats :loser_name" do |winner_name, loser_name|
      winner = @players.find { |player| player.name == winner_name }
      loser = @players.find { |player| player.name == loser_name }
      winner.beats(loser)
    end

    step ":player_name has played :n game(s)" do |player_name, n|
      player = @players.find { |player| player.name = player_name }
      (player.wins + player.losses).should == n
    end

Finally, it's time to specify how the `Player` class should work: `spec/features/players_feature.rb`

    require 'spec/support/step_helper'

    describe Player do
      before do
        given "a player named 'James' exists"
        and "a player named 'Anthony' exists"
        and "a player named 'Chris' exists"
      end

      it 'should track games played' do
        when "James beats Anthony"
        and "James beats Chris"
        and "Anthony beats James"

        then "James has played 3 game(s)"
        and "Anthony has played 2 game(s)"
        and "Chris has played 1 game(s)"
      end
    end
