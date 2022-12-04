# frozen_string_literal: true

module Day1
  class Part1 < BaseSolution
    def run
      prepare.max
    end

    def prepare
      chomped_lines.split('').map { |x| x.map(&:to_i).sum }
    end

    def self.expected_result
      24000
    end
  end
end
