# frozen_string_literal: true

module Day15
  class Part2 < BaseSolution
    def run
      grid = chomped_lines.map do |line|
        sx, sy, bx, by = line.scan(/-?\d+/).map(&:to_i)
        [sx, sy, manhattan(sx, sy, bx, by)]
      end

      grid.each do |sx, sy, sc|
        (0..sc).each do |pt|
          [
            [sx - sc - 1 + pt, sy - pt],
            [sx + sc + 1 - pt, sy - pt],
            [sx - sc - 1 + pt, sy + pt],
            [sx + sc + 1 - pt, sy + pt]
          ].each do |tx, ty|
            next unless (0..target_range) === tx && (0..target_range) === ty
            next unless grid.all? { |(ox, oy, od)| manhattan(tx, ty, ox, oy) > od }
            return tx * 4000000 + ty
          end
        end
      end
    end

    def manhattan(x1, y1, x2, y2)
      (x1-x2).abs + (y1-y2).abs
    end

    def target_range
      # 20 # for test input
      4_000_000 # for real input
    end

    def self.expected_result
      56000011
    end
  end
end
