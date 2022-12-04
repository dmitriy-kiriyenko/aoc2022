# frozen_string_literal: true

module Day1
  class Part2 < Part1
    def run
      prepare.sort[-3..-1].sum
    end

    def self.expected_result
      45000
    end
  end
end
