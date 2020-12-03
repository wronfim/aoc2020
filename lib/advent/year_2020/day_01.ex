# https://adventofcode.com/2020/day/1

defmodule Advent.Year2020.Day01 do
  def part1(input) when is_binary(input) do
    input
    |> str_to_list_of_numbers()
    |> part1()
  end

  def part1(input) do
    {n1, n2} = find_sum_target(input, 2020)
    n1 * n2
  end

  def part2(input) when is_binary(input) do
    input
    |> str_to_list_of_numbers()
    |> part2()
  end

  def part2([n1 | tail]) do
    case find_sum_target(tail, abs(n1-2020)) do
      nil -> part2(tail)
      {n2, n3} -> n1 * n2 * n3
    end
  end

  defp find_sum_target(nil, _target), do: nil
  defp find_sum_target([], _target), do: nil

  defp find_sum_target([n | tail], target) do
    case Enum.find(tail, fn number -> n + number == target end) do
      nil -> find_sum_target(tail, target)
      number -> {n, number}
    end
  end

  defp str_to_list_of_numbers(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
