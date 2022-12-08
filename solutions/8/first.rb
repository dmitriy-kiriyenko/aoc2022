# frozen_string_literal: true

module Day8
  class Part1 < BaseSolution
    def run
      @found = Set.new

      data = chomped_lines.each_with_index.map do |line, i|
        line.chars.map(&:to_i).each_with_index.map do |h, j|
          [h, [i, j]]
        end
      end

      slice_rows(data).each do |row|
        find_from_left(row)
        find_from_left(row.reverse)
      end

      slice_columns(data).each do |row|
        find_from_left(row)
        find_from_left(row.reverse)
      end

      @found.count
    end

    def self.expected_result()
      21
    end

    def slice_rows(data)
      data
    end

    def slice_columns(data)
      data.transpose
    end

    def find_from_left(data)
      @found.add(data.first.last)
      max = data.first.first
      data.each_cons(2) do |l, r|
        @found.add(r.last) if r.first > max
        max = [r.first, max].max
      end
    end
  end
end
