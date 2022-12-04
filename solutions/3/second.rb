# frozen_string_literal: true

module Day3
  class Part2 < Part1
    def run
      chomped_lines.each_slice(3).map do |first, second, third|
        common = first.chars & second.chars & third.chars
        raise 'fuck' if common.size != 1
        weight common.first
      end.sum
    end

    def self.expected_result
      70
    end
  end
end
