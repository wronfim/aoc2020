defmodule Advent.Year2020.Day03Test do
  use ExUnit.Case

  import Advent.Year2020.Day03

  @input """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  test "part1" do
    assert part1(@input) == 7
  end

  test "part2" do
    assert part2(@input) == 336
  end
end
