require_relative "../lib/day6"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day6Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      Time:      7  15   30
      Distance:  9  40  200
      EOF
      .split("\n")
      .reject {|l| l.empty?}
    configs = Advent::Day6.count_winning_configurations(input)

    assert_equal(288, configs.reduce(:*))
  end

  def test_part1
    input = Advent::Input.read_to_lines("day6.txt")
    configs = Advent::Day6.count_winning_configurations(input)

    assert_equal(2449062, configs.reduce(:*))
  end

  def test_example2
    input = <<~EOF
      Time:      7  15   30
      Distance:  9  40  200
      EOF
      .split("\n")
      .reject {|l| l.empty?}
    configs = Advent::Day6.count_winning_configurations(input, combine: true)

    assert_equal(71503, configs)
  end

  def test_part2
    input = Advent::Input.read_to_lines("day6.txt")
    configs = Advent::Day6.count_winning_configurations(input, combine: true)

    assert_equal(33149631, configs)
  end
end
