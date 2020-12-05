# https://adventofcode.com/2020/day/3

defmodule Advent.Year2020.Day03 do
  def part1(input) do
    toboggan = preprocess(input)
    slope = {3, 1}
    location = {0, 0, length(toboggan)}
    slide(toboggan, location, slope, 0)
  end

  def part2(input) do
    toboggan = preprocess(input)
    bottom = length(toboggan)

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&slide(toboggan, {0, 0, bottom}, &1, 0))
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp slide(_toboggan, {_x, y, bottom}, _slope, trees) when y >= bottom - 1, do: trees

  defp slide(toboggan, {x, y, bottom}, {right, down} = slope, trees) do
    location = {x + right, y + down, bottom}
    tree = count_trees(toboggan, location)
    slide(toboggan, location, slope, trees + tree)
  end

  defp count_trees(toboggan, {right, down, _bottom}) do
    row = Enum.at(toboggan, down)
    pos = String.length(row)

    row
    |> String.at(rem(right, pos))
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.get("#", 0)
  end

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
  end
end
