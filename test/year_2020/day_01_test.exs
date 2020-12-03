defmodule Advent.Year2020.Day01Test do
  use ExUnit.Case

  import Advent.Year2020.Day01

  @input """
  979
  366
  1721
  299
  675
  1456
  """

  test "part1" do
    assert part1(@input) == 514_579
  end

  test "part2" do
    assert part2(@input) == 241_861_950
  end
end
