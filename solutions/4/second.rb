# frozen_string_literal: true

module Day4
  class Part2 < Part1
    def count_condition?(r1, r2)
      (r1.begin - r2.end)*(r2.begin - r1.end) >= 0
    end

    def self.expected_result
      4
    end
  end
end
