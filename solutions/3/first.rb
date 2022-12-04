# frozen_string_literal: true

module Day3
  class Part1 < BaseSolution
    def run
      chomped_lines.map do |line|
        first, second = line.chars.each_slice(line.length / 2).map &:to_a
        common = first & second
        raise 'fuck' if common.size != 1
        weight common.first
      end.sum
    end

    def weight(char)
      case char
      when 'A'..'Z' then char.ord - 65 + 27
      when 'a'..'z' then char.ord - 96
      else raise 'wtf'
      end
    end

    def self.expected_result
      157
    end
  end
end
