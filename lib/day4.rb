module Advent
  class ScratchCard
    attr_reader :id, :numbers, :winners

    def initialize(input)
      @memo_matches = nil
      parse(input)
    end

    def matches
      @memo_matches ||= @numbers.reduce(0) do |matches, n|
        matches + (@winners.include?(n) ? 1 : 0)
      end
      @memo_matches
    end

    def score
      if matches > 0
        2 ** (matches - 1)
      else
        0
      end
    end

    private
    def parse(input)
      pattern = /\ACard\s+(\d+): ([\d\s]+) \| ([\d\s]+)\Z/
      id, numbers_segment, winners_segment = input.match(pattern).deconstruct
      @id = id.to_i
      @numbers = numbers_segment.split(/\s+/)
                                .reject {|n| n.empty?}
                                .map {|n| n.to_i}
      @winners = winners_segment.split(/\s+/)
                                .reject {|n| n.empty?}
                                .map {|n| n.to_i}
                                .to_set
    end
  end

  class Day4
    def self.score_cards(input_lines)
      input_lines.map {|line| ScratchCard.new(line)}
        .map {|c| c.score}
    end

    def self.scratch_all(input_lines)
      cards = input_lines.map {|line| ScratchCard.new(line)}
                         .to_h {|card| [card.id, card]}

      scratched = cards.keys.to_h {|id| [id, 1]}
      cascade = {}
      # Preload cascading effects
      cards.entries.each do |(id, card)|
        if card.matches > 0
          cascade[id] = (1..card.matches).map {|offset| id + offset}
        else
          cascade[id] = []
        end
      end

      cards.keys.sort.each do |id|
        cascade[id].each do |bonus_card|
          scratched[bonus_card] += scratched[id]
        end
      end

      scratched.values.reduce(:+)
    end
  end
end
