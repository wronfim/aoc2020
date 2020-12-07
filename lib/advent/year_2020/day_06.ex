defmodule Advent.Year2020.Day06 do
  def part1(input) do
    input
    |> preprocess()
    |> Enum.map(fn group ->
      group
      |> Enum.map(&String.codepoints/1)
      |> List.flatten
      |> Enum.uniq
      |> Enum.count
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> preprocess()
    |> Enum.map(fn group ->
      ?a..?z
      |> Enum.to_list()
      |> to_string()
      |> String.codepoints()
      |> Enum.filter(fn letter ->
        group
        |> Enum.all?(&String.contains?(&1, letter))
      end)
    end)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def preprocess(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&Enum.reject(&1, fn s -> s == "" end))
  end
end
