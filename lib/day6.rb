module Advent
  class Day6
    def self.count_winning_configurations(input, combine: false)
      if combine
        count_single_race(input)
      else
        count_multiple_races(input)
      end
    end

    def self.count_multiple_races(input)
      times = input[0].match(/\ATime:\s+([\d\s]+)\Z/).deconstruct.first.split(/\s+/).map {|n| n.to_i}
      distances = input[1].match(/\ADistance:\s+([\d\s]+)\Z/).deconstruct.first.split(/\s+/).map {|n| n.to_i}

      times.each_with_index
           .map do |race_time, race_index|
              distance = distances[race_index]
              (0..race_time-1).filter {|charge_time| charge_time * (race_time - charge_time) > distance}
                              .size
            end
    end

    def self.count_single_race(input)
      time = input[0].match(/\ATime:\s+([\d\s]+)\Z/).deconstruct.first.gsub(/\s+/, '').to_i
      distance = input[1].match(/\ADistance:\s+([\d\s]+)\Z/).deconstruct.first.gsub(/\s+/, '').to_i

      # y = ax^2 + bx + c
      # Example:
      # a = -1 (charge factor)
      # b = 7 (race time)
      # c = -10 (winning distance)
      left_root = (-time + Math.sqrt(time**2 - 4*(distance+1))) / -2.0
      right_root = (-time - Math.sqrt(time**2 - 4*(distance+1))) / -2.0
      right_root.ceil - left_root.ceil
    end
  end
end
