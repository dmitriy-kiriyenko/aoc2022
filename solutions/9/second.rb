# frozen_string_literal: true

module Day9
  class Part2 < Part1
    class Snake < SimpleSnake
      attr_reader :body

      def initialize(size)
        super()
        @body = Array.new(size - 2) { 0.to_c }
      end

      def process_move(dir)
        self.head += DIRS[dir]

        forehead = head
        (0...body.size).each do |idx|
          body[idx] += get_delta(from: body[idx], to: forehead)
          forehead = body[idx]
        end

        self.tail += get_delta(from: tail, to: body.last)
      end
    end

    def new_snake
      Snake.new(10)
    end

    def self.expected_result
      1
    end
  end
end
