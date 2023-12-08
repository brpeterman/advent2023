module Advent
  class Day8
    def self.find_end(input_lines)
      instructions, nodes = parse_input(input_lines)
      steps_to_end('AAA', nodes, instructions)
    end

    def self.find_ghost_end(input_lines)
      instructions, nodes = parse_input(input_lines)
      start_nodes = nodes.keys.filter {|k| k.end_with?('A')}
      start_nodes.map {|n| steps_to_end(n, nodes, instructions, any_end: true)}
                 .reduce(1, :lcm)
    end

    def self.steps_to_end(start_node, nodes, instructions, any_end: false)
      current_node = start_node
      steps = 0
      while (!any_end && current_node != 'ZZZ') || (any_end && !current_node.end_with?('Z'))
        instruction = instructions[steps % instructions.size]
        if instruction == 'L'
          current_node = nodes[current_node][0]
        else
          current_node = nodes[current_node][1]
        end
        steps += 1
      end
      steps
    end

    def self.parse_input(input_lines)
      instructions = input_lines[0].split("")

      nodes = input_lines.drop(1).reject {|l| l.empty?}
                         .reduce({}) do |hash, line|
                           start, left, right = line.match(/\A(\w{3}) = \((\w{3}), (\w{3})\)\Z/).deconstruct
                           hash[start] = [left, right]
                           hash
                         end
      [instructions, nodes]
    end
  end
end
