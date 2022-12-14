# frozen_string_literal: true

module Day14
  class Part1 < BaseSolution
    def run
      map, abyss = read_input
      simulate(map, abyss)
    end

    def read_input
      map = {}
      abyss = 0

      chomped_lines.each do |line|
        pairs = line.split(' -> ').map { |t| t.split(',').map(&:to_i) }
        pairs.each_cons(2) do |(x1, y1), (x2, y2)|
          x1, x2 = [x1, x2].sort
          y1, y2 = [y1, y2].sort

          (x1..x2).each do |x|
            (y1..y2).each do |y|
              map[x + y*1i] = '#'
              abyss = [abyss, y + 1].max
            end
          end
        end
      end

      [map, abyss]
    end

    def simulate(map, abyss)
      res = 0
      loop do
        s = 500.to_c

        until map.key?(s)
          return res if s.imag >= abyss

          new_s = [s+1i, s+1i-1, s+1i+1].detect { |new_s| !map.key?(new_s) }
          s = new_s and next if new_s

          map[s] = 'o'
          res += 1
        end
      end
    end

    def self.expected_result
      24
    end
  end
end
