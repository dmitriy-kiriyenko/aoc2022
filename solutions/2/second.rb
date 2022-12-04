# frozen_string_literal: true

module Day2
  class Part2 < Part1
    LOOSE_CONDITION = WIN_CONDITION.invert.freeze
    WIN_SCORE = {
      'X' => 0,
      'Y' => 3,
      'Z' => 6
    }.freeze

    def round_score(opponent, player)
      PLAYER_SCORE[x_to_turn(opponent, player)] + WIN_SCORE[player]
    end

    def x_to_turn(opponent, player)
      case player
      when 'X' then WIN_CONDITION[opponent]
      when 'Y' then opponent
      when 'Z' then LOOSE_CONDITION[opponent]
      end
    end

    def self.expected_result
      12
    end
  end
end
