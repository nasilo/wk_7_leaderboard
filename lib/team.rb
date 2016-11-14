class Team
  # YOUR CODE GOES HERE
  attr_reader :name
  attr_accessor :rank, :wins, :losses

  def initialize (team_name)
    @name = team_name
    @rank = nil
    @wins = 0
    @losses = 0
  end
end
