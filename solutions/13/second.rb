# frozen_string_literal: true

module Day13
  class Part2 < BaseSolution
    def run
      in_data = chomped_lines.map {|l| eval l }.compact
      dividers = [[[2]], [[6]]]
      dividers.each { |d| in_data.push(d) }
      sorted = in_data.sort { |l, r| cmp(l, r) }
      dividers.map { |d| sorted.index(d) + 1 }.reduce(:*)
    end

    def cmp(left, right)
      left = Array.wrap(left)
      right = Array.wrap(right)
      return left <=> right if left <=> right
      return -1 if left.empty? && !right.empty?
      return 1 if !left.empty? && right.empty?
      spaceship_first = left.first <=> right.first
      return spaceship_first if spaceship_first && rocket_first != 0
      cmp_first = cmp(left.first, right.first)
      return cmp_first if cmp_first != 0
      cmp(left[1..-1], right[1..-1])
    end

    def self.expected_result
      140
    end
  end
end
