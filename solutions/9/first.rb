# frozen_string_literal: true

require 'complex'

module Day9
  class Part1 < BaseSolution
    class SimpleSnake
      attr_accessor :head, :visited
      attr_reader :tail

      DIRS = {
        'L' => -1.to_c,
        'R' => 1.to_c,
        'U' => 0 + 1i,
        'D' => 0 - 1i
      }

      def initialize
        self.visited = Set.new
        self.head = 0.to_c
        self.tail = 0.to_c
      end

      def tail=(new_tail)
        @tail = new_tail
        visited.add(@tail)
        @tail
      end

      def move(dir, count)
        count.to_i.times { process_move(dir) }
      end

      def process_move(dir)
        self.head += DIRS[dir]
        self.tail += get_delta(from: tail, to: head)
      end

      def get_delta(from:, to:)
        current_delta = to - from

        return 0.to_c if current_delta.abs2 <= 2
        Complex(current_delta.real <=> 0, current_delta.imag <=> 0)
      end
    end

    def run
      snake = new_snake

      chomped_lines.each do |line|
        snake.move(*line.split(' '))
      end

      snake.visited.size
    end

    def new_snake
      SimpleSnake.new
    end

    def self.expected_result
      13
    end
  end
end
