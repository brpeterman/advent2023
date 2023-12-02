require 'pry-byebug'

module Advent
  class Day2
    class Game
      attr_accessor :id, :draws

      def initialize(id, input)
        @id = id
        @draws = parse(input)
      end

      def possible?(proposition)
        draws.reduce(true) do |possible, draw|
          possible && draw.reduce(true) do |draw_possible, (color, count)|
            draw_possible && count <= proposition.fetch(color, 0)
          end
        end
      end

      def minimal_blocks
        draws.reduce({}) do |blocks, draw|
          draw.each_entry do |color, count|
            blocks[color] = count unless blocks.fetch(color, 0) > count
          end
          blocks
        end
      end

      private
      def parse(input)
        input.split('; ').map do |draw_segment|
          draw_segment.split(', ').reduce({}) do |draw, cube_segment|
            count, color = cube_segment.match(/\A(\d+) (\w+)\Z/).deconstruct
            draw[color.to_sym] = count.to_i
            draw
          end
        end
      end
    end

    def self.find_possible(proposition, game_lines)
      game_lines.map { |line| parse_game(line) }
        .filter { |game| game.possible?(proposition) }
        .map { |game| game.id }
    end

    def self.find_minimal_block_powers(game_lines)
      game_lines.map { |line| parse_game(line) }
        .map { |game| game.minimal_blocks }
        .map { |blocks| blocks.reduce(1) { |product, (_, count)| product * count }}
    end

    def self.parse_game(line)
      pattern = /\AGame (\d+): (.+)\Z/
      id, draw_info = line.match(pattern).deconstruct
      Game.new(id.to_i, draw_info)
    end
  end
end
