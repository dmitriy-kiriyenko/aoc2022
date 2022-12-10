# frozen_string_literal: true

module Day10
  class Part2 < Part1
    def run
      processor = Processor.new
      chomped_lines.each do |line|
        processor.command(line)
      end
      processor.pretty_crt
    end

    def self.expected_result
<<CRT
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
CRT
    end
  end
end
