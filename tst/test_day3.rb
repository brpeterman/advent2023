require_relative "../lib/day3"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day3Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      EOF
      .split("\n")
      .reject { |l| l.empty? }
    part_numbers = Advent::Day3.find_part_numbers(input)

    assert_equal(4361, part_numbers.reduce(:+))
  end

  def test_part1
    input = Advent::Input.read_to_lines("day3.txt")
    part_numbers = Advent::Day3.find_part_numbers(input)

    assert_equal(543867, part_numbers.reduce(:+))
  end

  def test_example2
    input = <<~EOF
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      EOF
      .split("\n")
      .reject { |l| l.empty? }
    ratios = Advent::Day3.find_gear_ratios(input)

    assert_equal(467835, ratios.reduce(:+))
  end

  def test_part2
    input = Advent::Input.read_to_lines("day3.txt")
    ratios = Advent::Day3.find_gear_ratios(input)

    assert_equal(79613331, ratios.reduce(:+))
  end
end
