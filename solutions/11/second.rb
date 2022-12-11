# frozen_string_literal: true

module Day11
  class Part2 < Part1
    def process(monkeys)
      lcm = get_lcm(monkeys)
      10_000.times do |i|
        monkeys.each_value do |monkey|
          monkey.take_turn(monkeys) { |i| i % lcm }
        end
      end
    end

    def get_lcm(monkeys)
      monkeys.values.map(&:divisor).reduce { |acc, i| acc.lcm(i) }
    end

    def self.expected_result
      2713310158
    end
  end
end
