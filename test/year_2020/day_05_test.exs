defmodule Advent.Year2020.Day05Test do
  use ExUnit.Case

  import Advent.Year2020.Day05

  @input """
  FBFBBFFRLR
  """

  test "part1" do
    assert part1(@input) == 357
  end
end
