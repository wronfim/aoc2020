defmodule Advent.Year2020.Day05 do
  def part1(input) do
    input
    |> preprocess()
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&find_row(&1, {0, 127}))
    |> Enum.map(fn {row, list} -> {row, find_column(list, {0, 7})} end)
    |> Enum.map(fn {row, column} -> row * 8 + column end)
    |> Enum.max()
  end

  def part2(input) do
    input
    |> preprocess()
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&find_row(&1, {0, 127}))
    |> Enum.map(fn {row, list} -> {row, find_column(list, {0, 7})} end)
    |> Enum.map(fn {row, column} -> row * 8 + column end)
    |> Enum.sort()
    |> find_my_seat()
  end

  defp find_row(["B" | tail], {low, high} = range) when low < high - 1,
    do: find_row(tail, {low + middle(range), high})

  defp find_row(["F" | tail], {low, high} = range) when low < high - 1,
    do: find_row(tail, {low, high - middle(range)})

  defp find_row(["B" | tail], {_low, high}), do: {Kernel.trunc(high), tail}
  defp find_row(["F" | tail], {low, _high}), do: {Kernel.trunc(low), tail}

  defp find_column(["R" | tail], {low, high} = range) when low < high - 1,
    do: find_column(tail, {low + middle(range), high})

  defp find_column(["L" | tail], {low, high} = range) when low < high - 1,
    do: find_column(tail, {low, high - middle(range)})

  defp find_column(["R" | tail], {_low, high}), do: Kernel.trunc(high)
  defp find_column(["L" | tail], {low, _high}), do: Kernel.trunc(low)

  defp middle({low, high}), do: Float.round((high - low) / 2)

  defp find_my_seat([seat | _tail] = list), do: find_my_seat(list, seat)
  defp find_my_seat([seat | tail], seat), do: find_my_seat(tail, seat + 1)
  defp find_my_seat(_, seat), do: seat

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
  end
end
