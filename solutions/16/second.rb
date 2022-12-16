# frozen_string_literal: true

module Day16
  class Part2 < BaseSolution
    attr_reader :grid

    def run
      parse_data
      preprocess_data
      @b = 0
      dfs(0, [].to_set, 0, 'AA', 0 )
      @b
    end

    def dfs(pt, o, t, l, w)
      @b = [@b, pt].max
      grid[l].last.each do |a, d|
        passed = t + d + 1
        next if o.include?(a) || passed >= limit
        dfs(
          pt + (limit - passed) * grid[a].first,
          o | [a].to_set,
          passed,
          a,
          w
        )
      end
      dfs(pt, o, 0, 'AA', 1) if w == 0
    end

    def limit
      26
    end

    def parse_data
      @grid = {}

      chomped_lines.each do |line|
        # Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
        _valve, valve_name, _has, _flow, rate_str, _tunnels, _lead, _to, _valves, *target_valves = line.split(/[,;]?\s+/)
        rate = rate_str.split('=').last.to_i
        target_valves_map = target_valves.map { |v| [v, 1] }.to_h
        @grid[valve_name] = [rate, target_valves_map]
      end
    end

    def preprocess_data
      grid.keys.each do |k|
        grid.keys.each do |i|
          grid.keys.each do |j|
            next if i == j || j == k || i == k
            next unless grid[i].last.keys.include?(k) && grid[k].last.keys.include?(j)

            t = grid[i].last[k] + grid[k].last[j]
            grid[i].last[j] = t if !grid[i].last[j] || grid[i].last[j] > t
          end
        end
      end

      grid.select! { |k, v| k == 'AA' || v.first != 0 }
      grid.each { |_, v| v.last.select! { |kk| grid[kk] && grid[kk].first != 0 } }
    end

    def self.expected_result
      1707
    end
  end
end
