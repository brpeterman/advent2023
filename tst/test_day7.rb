require_relative "../lib/day7"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day7Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
      EOF
      .split("\n")
      .reject {|l| l.empty?}
    winnings = Advent::Day7.count_winnings(input)

    assert_equal(6440, winnings)
  end

  def test_part1
    input = Advent::Input.read_to_lines("day7.txt")
    winnings = Advent::Day7.count_winnings(input)

    assert_equal(248559379, winnings)
  end

  def test_example2
    input = <<~EOF
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
      EOF
      .split("\n")
      .reject {|l| l.empty?}
    winnings = Advent::Day7.count_winnings(input, use_jokers: true)

    assert_equal(5905, winnings)
  end

  def test_part2
    input = Advent::Input.read_to_lines("day7.txt")
    winnings = Advent::Day7.count_winnings(input, use_jokers: true)

    assert_equal(249631254, winnings)
  end
end
