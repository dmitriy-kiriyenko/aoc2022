# frozen_string_literal: true

module Day13
  class Part1 < BaseSolution
    def run
      chomped_lines.map {|l| eval l }.split(nil).each_with_index.select do |(left, right), i|
        cmp(left, right) == -1
      end.map(&:last).map {|x| x + 1}.sum
    end

    def cmp(left, right)
      left = Array.wrap(left)
      right = Array.wrap(right)
      return left <=> right if left <=> right
      return -1 if left.empty? && !right.empty?
      return 1 if !left.empty? && right.empty?
      spaceship_first = left.first <=> right.first
      return spaceship_first if spaceship_first && spaceship_first != 0
      cmp_first = cmp(left.first, right.first)
      return cmp_first if cmp_first != 0
      cmp(left[1..-1], right[1..-1])
    end

    def self.expected_result
      13
    end
  end
end
