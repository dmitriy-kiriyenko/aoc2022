# frozen_string_literal: true
require 'complex'

module Day12
  class Part1 < BaseSolution
    def run
      grid = {}

      start = -1-1i
      destination = -1-1i

      chomped_lines.each_with_index do |line, y|
        line.chars.each_with_index do |char, x|
          coord = Complex(x, y)
          if char == 'S'
            char = 'a'
            start = coord
          elsif char == 'E'
            char = 'z'
            destination = coord
          end
          grid[coord] = char
        end
      end

      get_dist(grid, start, destination)
    end

    def get_dist(grid, start, destination)
      visited = {}
      visited[start] = 0

      to_visit = []
      to_visit.push(start)

      deltas = [0+1i, 0-1i, 1+0i, -1+0i]

      while to_visit.any?
        current_coord = to_visit.shift()
        current_steps = visited[current_coord]
        deltas.each do |delta|
          next_coord = current_coord + delta
          next if visited.key?(next_coord) || !grid.key?(next_coord)

          if grid[next_coord].ord - grid[current_coord].ord <= 1
            visited[next_coord] = current_steps + 1
            to_visit.push(next_coord)
            return current_steps + 1 if next_coord == destination
          end
        end
      end
      nil
    end

    def self.expected_result
      31
    end
  end
end
