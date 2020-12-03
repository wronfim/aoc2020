# https://adventofcode.com/2020/day/2

defmodule Advent.Year2020.Day02 do
  def part1(input) do
    input
    |> preprocess()
    |> Enum.filter(fn entry ->
      times = count_letter(entry.password, entry.letter)
      times >= entry.min and times <= entry.max
    end)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> preprocess()
    |> Enum.filter(&validate_password/1)
    |> Enum.count()
  end

  defp validate_password(%{password: password, min: min, max: max, letter: letter}) do
    a = String.at(password, min - 1) == letter
    b = String.at(password, max - 1) == letter
    xor(a, b)
  end

  defp count_letter(password, letter) do
    password
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.get(letter, 0)
  end

  defp xor(a, b), do: (a or b) and not (a and b)

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(fn entry -> entry == "" end)
    |> Enum.map(fn entry ->
      [policy, password] = String.split(entry, ": ")
      [minmax, letter] = String.split(policy, " ")
      [min, max] = String.split(minmax, "-")
      %{
        min: String.to_integer(min),
        max: String.to_integer(max),
        letter: letter,
        password: password
      }
    end)
  end
end
