defmodule Advent.Year2020.Day10Test do
  use ExUnit.Case

  import Advent.Year2020.Day10

  @input """
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  """

  test "part1" do
    assert part1(@input) == {22, 10}
  end

  test "part2" do
    assert part2(@input) == 19208
  end
end
