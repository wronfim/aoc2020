defmodule Advent.Year2020.Day08Test do
  use ExUnit.Case

  import Advent.Year2020.Day08

  @input """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  test "part1" do
    assert part1(@input) == {:infinite_loop, 5}
  end

  test "part2" do
    assert part2(@input) == 8
  end
end
