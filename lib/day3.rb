module Advent
  class RangeCoords
    attr_accessor :row, :col_range

    def initialize(row, col_range)
      @row = row
      @col_range = col_range
    end

    def eql?(other)
      @row == other.row && @col_range.eql?(other.col_range)
    end

    def hash
      [@row, @col_range].hash
    end
  end

  class EngineGrid
    attr_accessor :numbers, :symbols

    def initialize(input_lines)
      @numbers = []
      @symbols = {}
      parse(input_lines)
    end

    def parse(input_lines)
      input_lines.each_with_index do |row_input, row|
        number_start = nil
        row_input.split("").each_with_index do |char, col|
          if char =~ /\d/
            number_start = col if number_start.nil?
          elsif number_start
            number = row_input[number_start..col-1].to_i
            @numbers << [number, RangeCoords.new(row, number_start..col-1)]
            number_start = nil
          end

          if not char =~ /\d|\./
            @symbols[RangeCoords.new(row, col)] = char
          end
        end
        if number_start
          number = row_input[number_start..-1].to_i
          @numbers << [number, RangeCoords.new(row, number_start..row_input.length-1)]
        end
      end
    end
  end

  class Day3
    def self.find_part_numbers(input_lines)
      grid = EngineGrid.new(input_lines)
      grid.numbers.filter do |(number, coords)|
        row_range = coords.row-1..coords.row+1
        col_range = coords.col_range.min-1..coords.col_range.max+1
        row_range.reduce(false) do |row_adjacent, r|
          row_adjacent || col_range.reduce(false) do |col_adjacent, c|
            col_adjacent || grid.symbols.has_key?(RangeCoords.new(r, c))
          end
        end
      end.map { |(number, _)| number }
    end

    def self.find_gear_ratios(input_lines)
      grid = EngineGrid.new(input_lines)
      gears = {}
      grid.numbers.filter do |(number, coords)|
        row_range = coords.row-1..coords.row+1
        col_range = coords.col_range.min-1..coords.col_range.max+1
        row_range.each do |r|
          col_range.each do |c|
            check_coords = RangeCoords.new(r, c)
            if grid.symbols[check_coords] == '*'
              if gears[check_coords].nil?
                gears[check_coords] = []
              end
              gears[check_coords] << number
            end
          end
        end
      end

      gears.entries.filter {|(_, gear)| gear.size == 2}
           .map {|(_, gear)| gear.reduce(:*)}
    end
  end
end
