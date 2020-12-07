defmodule Advent.Year2020.Day06Test do
  use ExUnit.Case

  import Advent.Year2020.Day06

  @input """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  test "part1" do
    assert part1(@input) == 11
  end

  test "part2" do
    assert part2(@input) == 6
  end
end
