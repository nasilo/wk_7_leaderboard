require 'spec_helper'

RSpec.describe Leaderboard do
  games_data = [{
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 17,
    away_score: 18
  },
  {
    home_team: "Broncos",
    away_team: "Jets",
    home_score: 24,
    away_score: 10
  }]
  let(:no_argument) { Leaderboard.new }
  let(:given_data) { Leaderboard.new(games_data) }

  describe ".new" do
  # YOUR CODE GOES HERE
    context "initializing without an argument defualts to GAME_INFO" do
      it "stores GAME_INFO as @games" do
        expect(no_argument.games).to include({
          home_team: "Steelers",
          away_team: "Patriots",
          home_score: 24,
          away_score: 31
        })
      end

      it "creates an array of team objects with a method" do
        expect(no_argument.teams.length).to eq(4)
        expect(no_argument.teams).to include(Team)
        expect(no_argument.teams[-1].name).to eq("Colts")
      end
    end

    context "initializing with a supplied array of game data" do
      it "stores the array as @games" do
        expect(given_data.games).to eq(games_data)
      end

      it "creates an array of team objects with a method" do
        expect(given_data.teams.length).to eq(3)
        expect(given_data.teams).to include(Team)
        expect(given_data.teams[-1].name).to eq("Jets")
      end
    end
  end

  describe ".data_search" do
    it "generates an array of team objects" do
      expect(no_argument.data_search[0].rank).to eq(nil)
      expect(no_argument.data_search).to include(Team)
    end

    context "iterates through games deterimining wins" do
      it "assigns win and loss figures to the objects" do
        expect(given_data.data_search[1].wins).to eq(2)
        expect(no_argument.data_search[0].wins).to eq(3)
        expect(no_argument.data_search[1].losses).to eq(2)
      end
    end
  end

  describe ".ranking" do
    it "iterates through the data_search array, comparing wins to assign ranks" do
      expect(given_data.teams[0].rank).to eq(1)
      expect(no_argument.teams[0].rank).to eq(1)
    end
  end

  describe ".summary" do
    it "returns a long string which includes headings" do
      expect(no_argument.summary).to be_a(String)
      expect(no_argument.summary).to include("Name")
      expect(given_data.summary).to include("Jets")

    end
  end
end
