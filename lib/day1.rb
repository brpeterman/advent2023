module Advent
  class Day1
    MAPPINGS = {
      'one' => 1,
      'two' => 2,
      'three' => 3,
      'four' => 4,
      'five' => 5,
      'six' => 6,
      'seven' => 7,
      'eight' => 8,
      'nine' => 9
    }

    def self.find_numbers(input_lines, include_words: false)
      input_lines.map { |line| find_number(line, include_words) }
    end

    def self.find_number(line, include_words)
      first = nil
      last = nil
      line.scan(pattern(include_words))
        .flatten
        .reject { |m| m.nil? }
        .each do |match|
        value = if match =~ /\d/
          match.to_i
        else
          MAPPINGS[match]
        end
        if !first
          first = value
          last = value
        else
          last = value
        end
      end
      first * 10 + last
    end

    def self.pattern(include_words)
      if include_words
        Regexp.new(MAPPINGS.keys.map { |k| "(#{k})"}
          .join("|") + '|(\d)')
      else
        /\d/
      end
    end
  end
end
