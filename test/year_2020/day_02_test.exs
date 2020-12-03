defmodule Advent.Year2020.Day02Test do
  use ExUnit.Case

  import Advent.Year2020.Day02

  @input """
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  """

  test "part1" do
    assert part1(@input) == 2
  end

  @tag :wip
  test "part2" do
    assert part2(@input) == 1
  end
end
