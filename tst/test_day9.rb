require_relative "../lib/day9"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day9Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      EOF
      .split("\n")
    next_values = Advent::Day9.extrapolate_all(input)

    assert_equal(114, next_values.reduce(:+))
  end

  def test_part1
    input = Advent::Input.read_to_lines("day9.txt")
    next_values = Advent::Day9.extrapolate_all(input)

    assert_equal(1980437560, next_values.reduce(:+))
  end

  def test_example2
    input = <<~EOF
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      EOF
      .split("\n")
    next_values = Advent::Day9.extrapolate_all(input, backwards: true)

    assert_equal(2, next_values.reduce(:+))
  end

  def test_part2
    input = Advent::Input.read_to_lines("day9.txt")
    next_values = Advent::Day9.extrapolate_all(input, backwards: true)

    assert_equal(977, next_values.reduce(:+))
  end
end
