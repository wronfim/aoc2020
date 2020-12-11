defmodule Advent.Year2020.Day11Test do
  use ExUnit.Case

  import Advent.Year2020.Day11

  @input """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  """

  test "part1" do
    assert part1(@input) == 37
  end

  test "part2" do
    assert part2(@input) == 26
  end
end
