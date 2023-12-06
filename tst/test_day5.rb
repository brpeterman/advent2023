require_relative "../lib/day5"
require_relative "../lib/input"
require "test/unit"
require 'pry-byebug'

class Day5Test < Test::Unit::TestCase
  def test_example1
    input = <<~EOF
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
      EOF
    locations = Advent::Day5.find_locations(input)

    assert_equal(35, locations.min)
  end

  def test_part1
    input = File.read("input/day5.txt")
    locations = Advent::Day5.find_locations(input)

    assert_equal(157211394, locations.min)
  end

  def test_example2
    input = <<~EOF
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
      EOF
    locations = Advent::Day5.find_minimal_location(input)

    assert_equal(46, locations.first.min)
  end

  def test_part2
    input = File.read("input/day5.txt")
    locations = Advent::Day5.find_minimal_location(input)

    assert_equal(50855035, locations.first.min)
  end
end
