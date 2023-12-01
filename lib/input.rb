module Advent
  class Input
    def self.read_to_lines(input_file)
      File.readlines("input/#{input_file}", chomp: true)
    end
  end
end
