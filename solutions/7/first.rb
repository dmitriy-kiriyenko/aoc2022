# frozen_string_literal: true

module Day7
  class Part1 < BaseSolution
    def run
      terminal = new_terminal
      chomped_lines.each do |line|
        terminal.process(line)
      end

      get_answer(terminal.root)
    end

    def new_terminal
      Terminal.new
    end

    def get_answer(root)
      root.select_dirs { |d| d.size <= 100_000 }.sum(&:size)
    end

    class Terminal
      attr_reader :root

      class Node
        attr_reader :name, :size
        attr_accessor :parent

        delegate :inspect, to: :to_h

        def initialize(name)
          @name = name
        end

        def to_h
          raise NotImplementedError
        end

        def select_dirs(&block)
          list_dirs.select(&block)
        end

        def list_dirs
          raise NotImplementedError
        end
      end

      class FileNode < Node
        def initialize(name, size)
          super(name)
          @size = size.to_i
        end

        def list_dirs
          []
        end

        def to_s
          "- #{name} (file, size = #{size})"
        end

        def to_h
          { name  => size }
        end
      end

      class DirNode < Node
        attr_reader :children

        def initialize(*)
          super
          @size = 0
          @children = []
        end

        def add_child(child)
          child.parent = self
          add_size(child.size)
          children.push(child)
        end

        def add_size(size)
          @size += size
          parent.add_size(size) if parent.present?
        end

        def list_dirs
          [self, *children.map(&:list_dirs).flatten]
        end

        def to_s
          [
            "- #{name} (dir calculated_size = #{size})",
            StrUtils.indented_lines(' ' * 2, children.map(&:to_s))
          ].join("\n")
        end

        def to_h
          { name => children.reduce({}) { |acc, c| acc.merge(c.to_h) } }
        end
      end

      def initialize
        @root = DirNode.new('/')
        @current_dir = @root
      end

      def to_s
        @root.to_s
      end

      def inspect
        @root.inspect
      end

      def process(line)
        case line
        when '$ cd /', '$ ls'
          # no op
        when '$ cd ..'
          move_up
        when /\$ cd (.+)/
          move_to $1
        when /(\d+) (.+)/
          store_file($2, $1)
        when /dir (.+)/
          store_dir($1)
        else raise "wtf #{line}"
        end
      end

      def move_up
        raise 'at the top' if @current_dir.parent.nil?
        @current_dir = @current_dir.parent
      end

      def move_to(name)
        @current_dir = @current_dir.children.detect { |c| c.name == name }
      end

      def store_file(name, size)
        @current_dir.add_child(FileNode.new(name, size))
      end

      def store_dir(name)
        @current_dir.add_child(DirNode.new(name))
      end
    end

    def self.expected_result
      '95437'
    end
  end
end
