require_relative "../lib/day8"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day8Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
      EOF
      .split("\n")
    steps = Advent::Day8.find_end(input)

    assert_equal(2, steps)
  end

  def test_example2
    input = <<~EOF
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      EOF
      .split("\n")
    steps = Advent::Day8.find_end(input)

    assert_equal(6, steps)
  end

  def test_part1
    input = Advent::Input.read_to_lines("day8.txt")
    steps = Advent::Day8.find_end(input)

    assert_equal(16531, steps)
  end

  def test_example3
    input = <<~EOF
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
      EOF
      .split("\n")
      steps = Advent::Day8.find_ghost_end(input)

      assert_equal(6, steps)
  end

  def test_part2
    input = Advent::Input.read_to_lines("day8.txt")
    steps = Advent::Day8.find_ghost_end(input)

    assert_equal(24035773251517, steps)
  end
end
