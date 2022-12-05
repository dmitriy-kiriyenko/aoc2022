# frozen_string_literal: true

module Day5
  class Part2 < Part1
    def new_crate_mover(data)
      CrateMover9001.new(data)
    end

    class CrateMover9001 < CrateMover9000
      def process_move(count, from_column, to_column)
        to_column.unshift(*from_column.shift(count))
      end
    end

    def self.expected_result
      "MCD"
    end
  end
end
