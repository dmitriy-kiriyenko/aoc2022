# frozen_string_literal: true

module Day6
  class Part1 < BaseSolution
    class Buffer
      attr_reader :size, :array

      def initialize(size)
        @size = size
        @array = []
      end

      def push_and_check(item)
        array.push(item)
        return false if array.size < size
        array.shift if array.size > size
        array.uniq.size == size
      end
    end

    def run
      # I actually won with this solution, but it's O(scrap) in terms of computation
      # and O(scary) in terms of memory, so I rewrited it afterwards
      #
      # read_file.chomp.chars.each_cons(size).to_a.index do |list|
      #   list.size == list.uniq.size
      # end + size

      buffer = Buffer.new(size)

      read_file.chomp.each_char.with_index do |ch, idx|
        return idx + 1 if buffer.push_and_check(ch)
      end
    end

    def size
      4
    end

    def self.expected_result
      7
    end
  end
end
