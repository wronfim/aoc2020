defmodule Advent.Year2020.Day07Test do
  use ExUnit.Case

  import Advent.Year2020.Day07

  @input """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  @input Advent.read(2020, 7)

  test "part1" do
    assert part1(@input) == 4
  end

  test "part2" do
    assert part2(@input) == nil
  end
end
