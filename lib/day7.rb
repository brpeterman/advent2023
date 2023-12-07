module Advent
  class Hand
    include Comparable

    attr_reader :cards, :bid

    def initialize(input, use_jokers: false)
      @use_jokers = use_jokers
      @ranks = build_ranks
      parse(input)
    end

    def strength
      return @strength_rank unless @strength_rank.nil?

      bins = {}
      @cards.each do |c|
        bins[c] = bins.fetch(c) {0} + 1
      end
      if five_of_a_kind(bins, @use_jokers)
        @strength_rank = 6
      elsif four_of_a_kind(bins, @use_jokers)
        @strength_rank = 5
      elsif full_house(bins, @use_jokers)
        @strength_rank = 4
      elsif three_of_a_kind(bins, @use_jokers)
        @strength_rank = 3
      elsif two_pair(bins, @use_jokers)
        @strength_rank = 2
      elsif one_pair(bins, @use_jokers)
        @strength_rank = 1
      else
        @strength_rank = 0
      end

      @strength_rank
    end

    def <=>(other)
      if strength != other.strength
        strength <=> other.strength
      else
        result = 0
        @cards.each_with_index do |card, i|
          if @ranks[card] != @ranks[other.cards[i]]
            result = @ranks[card] <=> @ranks[other.cards[i]]
            break
          end
        end
        result
      end
    end

    private
    def parse(input)
      cards_input, bid = input.split(/\s+/)
      @cards = cards_input.split('')
      @bid = bid.to_i
    end

    def build_ranks
      ranks = %w(2 3 4 5 6 7 8 9 T J Q K A).each_with_index.to_h {|c, i| [c, i]}
      if @use_jokers
        ranks['J'] = -1
      end
      ranks
    end

    def five_of_a_kind(bins, use_jokers)
      x_of_a_kind(5, bins, use_jokers)
    end

    def four_of_a_kind(bins, use_jokers)
      x_of_a_kind(4, bins, use_jokers)
    end

    def full_house(bins, use_jokers)
      if not use_jokers
        bins.any? {|_, count| count == 3} && bins.any? {|_, count| count == 2}
      else
        jokers = bins.fetch('J') {0}
        full_house(bins, false) ||
          (jokers == 1 && two_pair(bins, false)) ||
          (jokers == 1 &&
            bins.any? {|(c, count)| c != 'J' && count == 3} &&
            bins.any? {|(c, count)| c != 'J' && count == 1}) ||
          (jokers == 2 &&
            bins.any? {|(c, count)| c != 'J' && count == 2} &&
            bins.any? {|(c, count)| c != 'J' && count == 1})
      end
    end

    def three_of_a_kind(bins, use_jokers)
      x_of_a_kind(3, bins, use_jokers)
    end

    def two_pair(bins, use_jokers)
      if not use_jokers
        bins.select {|_, count| count == 2}.size == 2
      else
        jokers = bins.fetch('J') {0}
        two_pair(bins, false) ||
          (jokers == 1 &&
            bins.any? {|(c, count)| c != 'J' && count == 2} &&
            bins.any? {|(c, count)| c != 'J' && count == 1})
      end
    end

    def one_pair(bins, use_jokers)
      x_of_a_kind(2, bins, use_jokers)
    end

    def x_of_a_kind(amount, bins, use_jokers)
      if not use_jokers
        bins.any? {|(_, count)| count == amount}
      else
        jokers = bins.fetch('J') {0}
        x_of_a_kind(amount, bins, false) ||
          bins.any? {|(c, count)| c != 'J' && count == amount - jokers}
      end
    end
  end

  class Day7
    def self.count_winnings(input_lines, use_jokers: false)
      hands = input_lines.map {|l| Hand.new(l, use_jokers: use_jokers)}
      hands.sort.each_with_index.reduce(0) do |sum, (hand, i)|
        sum + hand.bid * (i+1)
      end
    end
  end
end
