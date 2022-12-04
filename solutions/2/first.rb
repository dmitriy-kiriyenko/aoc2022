# frozen_string_literal: true

module Day2
  class Part1 < BaseSolution
    X_TO_A = {
      'X' => 'A',
      'Y' => 'B',
      'Z' => 'C'
    }.freeze

    PLAYER_SCORE = {
      'A' => 1,
      'B' => 2,
      'C' => 3
    }.freeze

    WIN_CONDITION = {
      'A' => 'C',
      'B' => 'A',
      'C' => 'B'
    }.freeze

    def run
      process
    end

    def process
      chomped_lines.map do |l|
        round_score(*l.split(' '))
      end.sum
    end

    def round_score(opponent, player)
      player = X_TO_A[player]
      PLAYER_SCORE[player] + win_score(opponent, player)
    end

    def win_score(opponent, player)
      if WIN_CONDITION[player] == opponent
        6
      elsif player == opponent
        3
      else
        0
      end
    end

    def self.expected_result
      15
    end
  end
end
