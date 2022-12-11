# frozen_string_literal: true

module Day11
  class Part1 < BaseSolution
    class Monkey
      attr_reader :id, :items, :divisor, :operation, :true_monkey, :false_monkey
      attr_accessor :inspected_items

      def initialize(id, items, operation, divisor, true_monkey, false_monkey)
        @id = id
        @items = items
        @operation = operation
        @divisor = divisor
        @true_monkey = true_monkey
        @false_monkey = false_monkey
        @inspected_items = 0
      end

      def take_turn(monkey_group, &decrease_worry_level)
        items.each do |item|
          target_monkey_number, processed_item = inspect_item(item, &decrease_worry_level)
          monkey_group[target_monkey_number].receive_item(processed_item)
        end
        loose_all_items
      end

      def to_s
        "Monkey #{id}: #{items.join(', ')}"
      end

      def inspect_item(item, &decrease_worry_level)
        @inspected_items += 1
        old = item # for inner binding
        processed_item = decrease_worry_level.call(eval(operation))
        if processed_item % divisor == 0
          [true_monkey, processed_item]
        else
          [false_monkey, processed_item]
        end
      end

      def receive_item(new_item)
        items.push(new_item)
      end

      def loose_all_items
        @items = []
      end
    end

    def run
      monkeys = chomped_lines.map(&:strip).split('').map do |(id_line, item_line, operation_line, test_line, true_line, false_line)|
        id = id_line.chomp(':').split(' ').last.to_i
        items = item_line.split(': ').last.split(', ').map(&:to_i)
        operation = operation_line.split(': ').last
        divisor = test_line.split(' ').last.to_i
        true_monkey = true_line.split(' ').last.to_i
        false_monkey = false_line.split(' ').last.to_i

        Monkey.new id, items, operation, divisor, true_monkey, false_monkey
      end.index_by(&:id)

      process monkeys

      monkey_business = monkeys.values.map(&:inspected_items)
      monkey_business.sort.reverse.take(2).reduce('*')
    end

    def process(monkeys)
      20.times do |i|
        monkeys.each_value do |monkey|
          monkey.take_turn(monkeys) { |i| i / 3 }
        end
      end
    end

    def gcd(monkeys)
      monkeys.values.map(&:divisor).reduce { |acc, i| acc.gcd(i) }
    end

    def self.expected_result
      10605
    end
  end
end
