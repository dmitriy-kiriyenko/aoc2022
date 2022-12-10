# frozen_string_literal: true

module Day10
  class Part1 < BaseSolution
    class Processor
      attr_reader :x, :cycle, :history, :crt

      def initialize
        @crt = '.' * 240
        @history = []
        @cycle = 0
        @x = 1
      end

      def command(cmd)
        cmd, value = *cmd.split(' ')
        case cmd
        when 'noop'
          next_cycle
        when 'addx'
          next_cycle
          next_cycle
          @x += value.to_i
        end
      end

      def next_cycle
        @cycle += 1
        history[cycle] = x
        if (x-1..x+1).include?((cycle-1) % 40)
          crt[cycle-1] = '#'
        end
      end

      def pretty_crt
        "#{crt.chars.each_slice(40).map(&:join).join("\n")}\n"
      end
    end

    def target_indexes
      [20, 60, 100, 140, 180, 220]
    end

    def run
      processor = Processor.new
      chomped_lines.each do |line|
        processor.command(line)
      end

      processor.history.values_at(*target_indexes).zip(target_indexes).map { |x, y| x*y }.sum
    end

    def self.expected_result
      13140
    end
  end
end
