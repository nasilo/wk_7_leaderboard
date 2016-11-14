class Leaderboard
GAME_INFO = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 17,
      away_score: 13
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 24,
      away_score: 7
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 21,
      away_score: 17
    },
    {
      home_team: "Broncos",
      away_team: "Steelers",
      home_score: 11,
      away_score: 27
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 24,
      away_score: 31
    }
]

# YOUR CODE GOES HERE
  attr_reader :games, :teams

  def initialize(games_data = GAME_INFO)
    @games = games_data
    @teams = ranking
    puts summary
  end

  def data_search
    team_names = []
    team_objects = []

    @games.each do |game|
      winner = nil

      if game[:home_score] > game[:away_score]
        winner = game[:home_team]
        losser = game[:away_team]
      else
        winner = game[:away_team]
        losser = game[:home_team]
      end

      if !team_names.include?(game[:home_team])
        team_names << game[:home_team]
        team_objects << Team.new(game[:home_team])
      end
      if !team_names.include?(game[:away_team])
        team_names << game[:away_team]
        team_objects << Team.new(game[:away_team])
      end

      team_objects.each do |team|
        if team.name == winner
          team.wins += 1
        elsif team.name == losser
          team.losses += 1
        end
      end
    end
    team_objects
  end

  def ranking
    #take in this
    initial_array = data_search
    destructable_array = data_search
    #output this
    final_array = []
    #setup data here
    current_rank = 0

    #iterate through for each rank
    initial_array.length.times do
      most_wins = 0
      most_losses = 0
      current_rank += 1
      #iterate through to find most wins
      destructable_array.each do |team|
        #exclude previously ranked teams
        unless final_array.include?(team)
          if team.wins > most_wins
            most_wins = team.wins
          end
          if team.losses > most_losses
            most_losses = team.losses
          end
        end
      end
      #select most wins for this round
      the_winningest = destructable_array.select{|team| team.wins == most_wins}
      #exclude those with more losses
      the_least_losses = nil
      the_winningest.each do |team|
        if the_least_losses.nil?
          the_least_losses = team.losses
        elsif team.losses < the_least_losses
          the_least_losses = team.losses
        end
      end
      the_most_winningest = the_winningest.select do |team|
        team.losses == the_least_losses
      end
      #place into final_array
      the_most_winningest.each do |team|
        team.rank = current_rank
        final_array << team
        destructable_array.delete(team)
      end
    end
    #output final_array
    final_array
  end

  def summary
    leaderboard_str = ""
    line = ""
    line_start = "| "
    line_end = " |\n"
    #generate a top line
    54.times {|column| line += "-"}
    line += "\n"
    leaderboard_str += line

    #generate a headings
    #2+12
    leaderboard_str += "| Name"
    8.times {|column| leaderboard_str += " "}
    #10
    leaderboard_str += "Rank"
    6.times {|column| leaderboard_str += " "}
    #14
    leaderboard_str += "Total Wins"
    4.times {|column| leaderboard_str += " "}
    #14 + 2
    leaderboard_str += "Total Losses"
    2.times {|column| leaderboard_str += " "}
    leaderboard_str += line_end

    #fill body
    @teams.each do |team|
      #team
      leaderboard_str += line_start
      leaderboard_str += "#{team.name}"
      spaces = 12 - team.name.length
      spaces.times {|column| leaderboard_str += " "}
      #rank
      leaderboard_str += "#{team.rank}"
      spaces = 10 - team.rank.to_s.length
      spaces.times {|column| leaderboard_str += " "}
      #wins
      leaderboard_str += "#{team.wins}"
      spaces = 14 - team.wins.to_s.length
      spaces.times {|column| leaderboard_str += " "}
      #losses
      leaderboard_str += "#{team.losses}"
      spaces = 14 - team.losses.to_s.length
      spaces.times {|column| leaderboard_str += " "}

      leaderboard_str += line_end
    end

    #generate bottom line
    leaderboard_str += line
    #output string
    leaderboard_str
  end
end
