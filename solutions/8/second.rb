# frozen_string_literal: true

module Day8
  class Part2 < Part1
    def run
      @data = chomped_lines.map do |line|
        line.chars.map(&:to_i)
      end

      scenic_scores = (0...@data.size).to_a.flat_map do |i|
        (0...@data.first.size).to_a.map do |j|
          directions.reduce(1) do |acc, dir|
            acc * scenic_score([i, j], dir)
          end
        end
      end

      scenic_scores.max
    end

    def scenic_score(from, dir)
      i, j = *from
      di, dj = *dir
      result = 0
      while next_tree = safe_dig(i += di, j += dj)
        result += 1
        break if next_tree >= @data[from.first][from.last]
      end
      result
    end

    def directions
      [[0, 1], [1, 0], [0, -1], [-1, 0]]
    end

    def safe_dig(i, j)
      @data.dig(i, j) if i >= 0 && j >= 0
    end

    def self.expected_result
      8
    end
  end
end
