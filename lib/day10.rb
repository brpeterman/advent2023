module Advent
  class Coords
    attr_reader :row, :col

    def initialize(row, col)
      @row = row
      @col = col
    end

    def +(other)
      Coords.new(@row + other.row, @col + other.col)
    end

    def eql?(other)
      @row == other.row && @col == other.col
    end

    def hash
      [@row, @col].hash
    end
  end

  class PipeNode
    attr_reader :north, :south, :east, :west

    def initialize(north: false, south: false, east: false, west: false)
      @north = north
      @south = south
      @east = east
      @west = west
    end

    def self.from_char(char)
      case char
      when '.'
        nil
      when 'S'
        :start
      when '|'
        PipeNode.new(north: true, south: true)
      when '-'
        PipeNode.new(east: true, west: true)
      when 'L'
        PipeNode.new(north: true, east: true)
      when 'J'
        PipeNode.new(north: true, west: true)
      when '7'
        PipeNode.new(south: true, west: true)
      when 'F'
        PipeNode.new(south: true, east: true)
      end
    end

    def neighbors(coords)
      nodes = []
      nodes << coords + Coords.new(-1, 0) if @north
      nodes << coords + Coords.new(1, 0) if @south
      nodes << coords + Coords.new(0, 1) if @east
      nodes << coords + Coords.new(0, -1) if @west
      nodes
    end
  end

  class Day10
    def self.find_max_distance(input_lines)
      map, start = parse_map(input_lines)
      loop = find_loop(map, start)
      loop.size / 2
    end

    def self.find_enclosed(input_lines)
      map, start = parse_map(input_lines)
      loop = find_loop(map, start)
      max_row = map.keys.max_by {|c| c.row}.row
      max_col = map.keys.max_by {|c| c.col}.col

      enclosed = 0
      (1..max_row-1).each do |row|
        (1..max_col-1).each do |col|
          if loop.include?(Coords.new(row, col))
            next
          end
          # Project a ray to the right, counting crossings
          # Odd number of crossings => enclosed
          north = 0
          south = 0
          (col+1..max_col).each do |ray_col|
            cell = Coords.new(row, ray_col)
            if loop.include?(cell)
              north += 1 if map[cell].north
              south += 1 if map[cell].south
            end
          end

          # Matched N/S is a definite crossing
          # Pairs of whatever is left cancel out, and it should be impossible to have an odd number of those
          if [north, south].min % 2 == 1
            enclosed += 1
          end
        end
      end
      enclosed
    end

    def self.find_loop(map, start)
      visited = Set.new
      visited.add(start)
      to_visit = map[start].neighbors(start)
      iterations = 0
      while !to_visit.empty?
        coords = to_visit.shift
        visited.add(coords)
        neighbors = map[coords].neighbors(coords)
        next_coords = neighbors.reject {|c| visited.include?(c)}
        if !next_coords.empty?
          to_visit.push(*next_coords)
        end
      end

      visited
    end

    def self.parse_map(input_lines)
      map = {}
      start = nil
      input_lines.each_with_index do |line, row|
        line.split('').each_with_index do |char, col|
          node = PipeNode.from_char(char)
          if node == :start
            start = Coords.new(row, col)
          end
          map[Coords.new(row, col)] = node unless node.nil? || node == :start
        end
      end
      map[start] = start_shape(map, start)
      [map, start]
    end

    def self.start_shape(map, start)
      north = start + Coords.new(-1, 0)
      south = start + Coords.new(1, 0)
      east = start + Coords.new(0, 1)
      west = start + Coords.new(0, -1)
      has_north = !map[north].nil? && map[north].south
      has_south = !map[south].nil? && map[south].north
      has_east = !map[east].nil? && map[east].west
      has_west = !map[west].nil? && map[west].east
      PipeNode.new(north: has_north, south: has_south, east: has_east, west: has_west)
    end
  end
end
