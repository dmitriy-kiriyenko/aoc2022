# frozen_string_literal: true

module Day7
  class Part2 < Part1
    def get_answer(root)
      unuzed_space = 70000000 - root.size
      required_space = 30000000 - unuzed_space

      root.select_dirs { |d| d.size >= required_space }.min_by(&:size).size
    end

    def self.expected_result
      24933642
    end
  end
end
