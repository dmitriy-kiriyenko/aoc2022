# frozen_string_literal: true

module Day15
  class Part1 < BaseSolution
    def run
      grid = chomped_lines.map do |line|
        sx, sy, bx, by = line.scan(/-?\d+/).map(&:to_i)
        [sx, sy, manhattan(sx, sy, bx, by)]
      end

      xl = Float::INFINITY
      xh = -Float::INFINITY

      grid.each do |sx, sy, sc|
        dx = sc - (target_row - sy).abs

        next unless dx > 0

        xl = [xl, sx - dx].min
        xh = [xh, sx + dx].max
      end

      xh - xl
    end

    def manhattan(x1, y1, x2, y2)
      (x1-x2).abs + (y1-y2).abs
    end

    def target_row
      10 # for test input
      # 2_000_000 # for real input
    end

    def self.expected_result
      26
    end
  end
end
