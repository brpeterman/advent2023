require_relative "../lib/day2"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day2Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      EOF
      .split("\n")
      .reject { |l| l.empty? }
    proposition = {
      red: 12,
      green: 13,
      blue: 14
    }
    possible_ids = Advent::Day2.find_possible(proposition, input)

    assert_equal(8, possible_ids.reduce(:+))
  end

  def test_part1
    input = Advent::Input.read_to_lines("day2.txt")
    proposition = {
      red: 12,
      green: 13,
      blue: 14
    }
    possible_ids = Advent::Day2.find_possible(proposition, input)

    assert_equal(2085, possible_ids.reduce(:+))
  end

  def test_example2
    input = <<~EOF
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      EOF
      .split("\n")
      .reject { |l| l.empty? }
    block_powers = Advent::Day2.find_minimal_block_powers(input)

    assert_equal(2286, block_powers.reduce(:+))
  end

  def test_part2
    input = Advent::Input.read_to_lines("day2.txt")
    block_powers = Advent::Day2.find_minimal_block_powers(input)

    assert_equal(79315, block_powers.reduce(:+))
  end
end
