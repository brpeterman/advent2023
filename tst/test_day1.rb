require_relative "../lib/day1"
require_relative "../lib/input"
require "test/unit"

class Day1Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      EOF
      .split("\n")
      .reject { |l| l.empty? }

    numbers = Advent::Day1.find_numbers(input)

    assert_equal(142, numbers.reduce(:+))
  end

  def test_part1
    input = Advent::Input.read_to_lines("day1.txt")

    numbers = Advent::Day1.find_numbers(input)

    assert_equal(53334, numbers.reduce(:+))
  end

  def test_example2
    input = <<~EOF
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      EOF
      .split("\n")
      .reject { |l| l.empty? }

      numbers = Advent::Day1.find_numbers(input, include_words: true)

      assert_equal(281, numbers.reduce(:+))
  end

  def test_part2
    input = Advent::Input.read_to_lines("day1.txt")

    numbers = Advent::Day1.find_numbers(input, include_words: true)

    assert_equal(52834, numbers.reduce(:+))
  end
end
