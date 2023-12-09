module Advent
  class Day9
    def self.extrapolate_all(input_lines, backwards: false)
      input_lines.map do |line|
        sequence = line.split(/\s+/).map {|n| n.to_i}
        if backwards
          extrapolate_backwards(sequence)
        else
          extrapolate(sequence)
        end
      end
    end

    def self.extrapolate(sequence)
      if sequence.all? {|n| n == 0}
        0
      else
        new_sequence = sequence.each_cons(2).map {|(a, b)| b - a}
        sequence.last + extrapolate(new_sequence)
      end
    end

    def self.extrapolate_backwards(sequence)
      if sequence.all? {|n| n == 0}
        0
      else
        new_sequence = sequence.each_cons(2).map {|(a, b)| b - a}
        sequence.first - extrapolate_backwards(new_sequence)
      end
    end
  end
end
