require_relative "../lib/day10"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day10Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      7-F7-
      .FJ|7
      SJLL7
      |F--J
      LJ.LJ
      EOF
      .split("\n")
    max_distance = Advent::Day10.find_max_distance(input)

    assert_equal(8, max_distance)
  end

  def test_part1
    input = Advent::Input.read_to_lines("day10.txt")
    max_distance = Advent::Day10.find_max_distance(input)

    assert_equal(6947, max_distance)
  end

  def test_example2
    input = <<~EOF
      ..........
      .S------7.
      .|F----7|.
      .||OOOO||.
      .||OOOO||.
      .|L-7F-J|.
      .|II||II|.
      .L--JL--J.
      ..........
      EOF
      .split("\n")
    enclosed = Advent::Day10.find_enclosed(input)

    assert_equal(4, enclosed)
  end

  def test_example3
    input = <<~EOF
      .F----7F7F7F7F-7....
      .|F--7||||||||FJ....
      .||.FJ||||||||L7....
      FJL7L7LJLJ||LJ.L-7..
      L--J.L7...LJS7F-7L7.
      ....F-J..F7FJ|L7L7L7
      ....L7.F7||L7|.L7L7|
      .....|FJLJ|FJ|F7|.LJ
      ....FJL-7.||.||||...
      ....L---J.LJ.LJLJ...
      EOF
      .split("\n")
    enclosed = Advent::Day10.find_enclosed(input)

    assert_equal(8, enclosed)
  end

  def test_example4
    input = <<~EOF
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
      EOF
      .split("\n")
    enclosed = Advent::Day10.find_enclosed(input)

    assert_equal(10, enclosed)
  end

  def test_part2
    input = Advent::Input.read_to_lines("day10.txt")
    enclosed = Advent::Day10.find_enclosed(input)

    assert_equal(273, enclosed)
  end
end
