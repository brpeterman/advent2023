module Advent
  class Mapping
    attr_reader :source_type, :destination_type, :mappings

    def initialize(input, invert: false)
      @mappings = {}
      parse(input, invert)
    end

    def map(source_value)
      mapping_entry = @mappings.select {|key| key === source_value}.first
      return source_value if mapping_entry.nil?

      source_range, destination_start = mapping_entry
      (source_value - source_range.min) + destination_start
    end

    def map_range(input_range)
      output_ranges = []
      @mappings.entries.each do |(mapping_range, destination)|
        if input_range.min > mapping_range.max || input_range.max < mapping_range.min
          next
        elsif mapping_range.cover? input_range
          # Apply to the whole range
          offset = input_range.min - mapping_range.min
          output_ranges << (map(input_range.min)..map(input_range.max))
        elsif input_range.min < mapping_range.min && input_range.max <= mapping_range.max
          # Apply to a segment on the right
          left = input_range.min..mapping_range.min-1
          right = map(mapping_range.min)..map(input_range.max)
          output_ranges += [right, map_range(left)].flatten
        elsif input_range.max > mapping_range.max && input_range.min >= mapping_range.min
          # Apply to a segment on the left
          right = mapping_range.max+1..input_range.max
          left = map(input_range.min)..map(mapping_range.max)
          output_ranges += [left, map_range(right)].flatten
        elsif input_range.cover? mapping_range
          # Apply to a segment in the middle
          left = input_range.min..mapping_range.min-1
          right = mapping_range.max+1..input_range.max
          middle = map(mapping_range.min)..map(mapping_range.max)
          output_ranges += [middle, map_range(left), map_range(right)].flatten
        end
      end
      if output_ranges.empty?
        output_ranges << input_range
      end

      output_ranges.sort {|a, b| a.min <=> b.min}
    end

    private
    def parse(input, invert)
      title, *input_lines = input.split("\n").reject {|l| l.empty?}
      source_type, destination_type = title.match(/\A(\w+)-to-(\w+) map:\Z/).deconstruct
      if invert
        source_type, destination_type = [destination_type, source_type]
      end
      @source_type, @destination_type = [source_type, destination_type]
      input_lines.each do |line|
        destination_start, source_start, range = line.split(/\s+/).map {|n| n.to_i}
        if invert
          source_start, destination_start = [destination_start, source_start]
        end
        @mappings[source_start..(source_start + range-1)] = destination_start
      end
    end
  end

  class Day5
    def self.find_locations(input)
      seeds_input, *map_inputs = input.split("\n\n").reject {|l| l.empty?}
      seeds_str = seeds_input.match(/\Aseeds:\s+([\d\s]+)\Z/).deconstruct.first
      seeds = seeds_str.split(/\s+/).map {|n| n.to_i}

      mappings = map_inputs.map {|definition| Mapping.new(definition)}
                           .to_h {|mapping| [mapping.source_type, mapping]}

      seeds.map {|seed| map_to(seed, mappings, 'seed', 'location')}
    end

    def self.map_to(seed, mappings, initial_source, final_destination)
      source = initial_source
      mapping = mappings[source]
      value = seed
      while source != final_destination
        value = mapping.map(value)
        source = mapping.destination_type
        mapping = mappings[source]
      end
      value
    end

    def self.find_minimal_location(input)
      seeds_input, *map_inputs = input.split("\n\n").reject {|l| l.empty?}
      seeds_str = seeds_input.match(/\Aseeds:\s+([\d\s]+)\Z/).deconstruct.first

      seed_ranges = seeds_str.split(/\s+/).map {|n| n.to_i}
                             .each_slice(2)
                             .map {|(start, length)| start..(start + length-1)}

      mappings = map_inputs.map {|definition| Mapping.new(definition)}
                          .to_h {|mapping| [mapping.source_type, mapping]}

      location_ranges = seed_ranges.map{|range| map_range_to(range, mappings, 'seed', 'location')}.flatten.sort {|a, b| a.min <=> b.min}
    end

    def self.map_range_to(range, mappings, initial_source, final_destination)
      source = initial_source
      mapping = mappings[source]
      current_ranges = [range]
      while source != final_destination
        current_ranges = current_ranges.map{|r| mapping.map_range(r) }.flatten.sort {|a, b| a.min <=> b.min}
        # Merge and sort

        source = mapping.destination_type
        mapping = mappings[source]
      end
      current_ranges
    end
  end
end
