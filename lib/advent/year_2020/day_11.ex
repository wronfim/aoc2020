defmodule Advent.Year2020.Day11 do
  def part1(input) do
    input
    |> preprocess()
    |> layout_to_map()
    |> run(4, false)
    |> Map.values()
    |> Enum.count(& &1 == "#")
  end

  def part2(input) do
    input
    |> preprocess()
    |> layout_to_map()
    |> run(5, true)
    |> Map.values()
    |> Enum.count(& &1 == "#")
  end

  defp run(layout, max_seats, recursive) do
    new_layout =
      layout
      |> Map.keys()
      |> Enum.reduce(layout, fn (seat, acc) ->
        new_status = check_around(layout, seat, max_seats, recursive)
        Map.put(acc, seat, new_status)
      end)

    if compare_maps(new_layout, layout) do
      new_layout
    else
      run(new_layout, max_seats, recursive)
    end
  end

  defp check_around(layout, seat, max_seats, recursive) do
    status = Map.get(layout, seat)

    [{0, -1}, {0, 1}, {-1, 0}, {1, 0}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
    |> Enum.map(&count_move(layout, seat, &1, recursive))
    |> Enum.sum()
    |> apply_rule(seat, status, max_seats)
  end

  defp count_move(layout, {row, col}, {row_offset, col_offset} = move, recursive) do
    seat = {row+row_offset, col+col_offset}
    layout
    |> Map.get(seat)
    |> case do
      "." -> if recursive, do: count_move(layout, seat, move, true), else: 0
      "#" -> 1
      _ -> 0
    end
  end

  defp apply_rule(count, _seat, "#", max_seats) when count >= max_seats, do: "L"
  defp apply_rule(0, _seat, "L", _), do: "#"
  defp apply_rule(_count, _seat, status, _), do: status

  defp compare_maps(m1, m2) do
    m1
    |> Map.keys()
    |> Enum.all?(fn seat ->
      Map.get(m1, seat) == Map.get(m2, seat)
    end)
  end

  defp layout_to_map(layout) do
    rows = Enum.count(layout)
    cols = layout |> List.first() |> Enum.count()
    0..rows-1
    |> Enum.map(fn row ->
      0..cols-1
      |> Enum.map(fn col -> {row, col} end)
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn {row, col}, acc ->
      value = layout |> Enum.at(row) |> Enum.at(col)
      Map.put(acc, {row, col}, value)
    end)
  end

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.map(& String.split(&1, ""))
    |> Enum.map(&Enum.reject(&1, fn s -> s == "" end))
    |> Enum.reject(& &1 == [])
  end
end
