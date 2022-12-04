# frozen_string_literal: true

module Day4
  class Part1 < BaseSolution
    def run
      chomped_lines.count do |line|
        r1, r2 = line.split(',').map do |s|
          s1, s2 = s.split('-').map(&:to_i)
          (s1..s2)
        end

        count_condition?(r1, r2)
      end
    end

    def count_condition?(r1, r2)
      (r1.begin - r2.begin)*(r2.end - r1.end) >= 0
    end

    def self.expected_result
      2
    end
  end
end
