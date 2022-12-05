# frozen_string_literal: true

module Day5
  class Part1 < BaseSolution
    def run
      crate_data, move_data = chomped_lines.split('')
      crate_mover = new_crate_mover(crate_data[0..-2])

      move_data.each do |move_command|
        crate_mover.move(move_command)
      end

      crate_mover.top_line
    end

    def new_crate_mover(data)
      CrateMover9000.new(data)
    end

    class CrateMover9000
      attr_reader :column_list

      def initialize(lines)
        line_list = pad(lines.map do |line|
          line.chars.each_slice(4).map { |l| l.join.strip[1] }
        end, :end)
        @column_list = line_list.transpose.map(&:compact)
      end

      def move(move_command)
        count, from, to = move_command.split(' ').map(&:to_i).values_at(1, 3, 5)
        process_move(count, column_list[from - 1], column_list[to - 1])
      end

      def process_move(count, from_column, to_column)
        count.times do
          to_column.unshift(from_column.shift)
        end
      end

      def top_line
        column_list.map(&:first).join
      end

      def pad(parsed_lines, where)
        max_size = parsed_lines.map(&:size).max
        parsed_lines.map do |line|
          pad_line = ([nil] * (max_size - line.size))
          where == :end ? line + pad_line : pad_line + line
        end
      end

      # METHODS FOR DEBUGGING
      def pretty_print
        pad(column_list, :start).transpose.map { |l| l.map { |c| c.present? ? "[#{c}]" : '   ' }.join(' ') } << pretty_bottom
      end
      alias_method :to_s, :pretty_print

      def pretty_bottom
        column_list.size.times.map { |i| " #{i+1} " }.join(' ')
      end
    end

    def self.expected_result
      "CMZ"
    end
  end
end
