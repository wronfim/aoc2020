defmodule Advent.Year2020.Day01Test do
  use ExUnit.Case

  import Advent.Year2020.Day01

  @input [979, 366, 1721, 299, 675, 1456]

  test "part1" do
    assert part1(@input) == 514579
  end

  test "part2" do
    assert part2(@input) == 241861950
  end
end
