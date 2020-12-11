defmodule Advent.Year2020.Day10 do
  def part1(input) do
    input = input |> preprocess()
    %{"3" => three, "1" => one} = find_adapters(input, 0, max_jolts(input), %{"1" => 0, "3" => 0})
    {one, three}
  end

  defp find_adapters(input, jolts,  max, counter) do
    if (max - jolts == 3) do
      Map.put(counter, "3", Map.get(counter, "3")+1)
    else
      adapters =
        input
        |> Enum.filter(fn a ->
          diff = (a - jolts)
          diff == 1 or diff == 3 or diff == 2
        end)
      adapter = adapters |> Enum.min()
      diff = (adapter - jolts) |> Integer.to_string()
      new_counter = Map.put(counter, diff, Map.get(counter, diff)+1)
      find_adapters(input, adapter, max, new_counter)
    end
  end

  defp find_combinations(input, start, max) do
    key = Integer.to_string(start)
    case LruCache.get(:my_cache, key) do
      nil ->
        res = find_combination(input, start, max)
        LruCache.put(:my_cache, key, res)
        res
      res -> res
    end
  end

  defp find_combination(_input, max, max), do: 1
  defp find_combination(input, start, max) do
    1..3
    |> Enum.reduce(0, fn  i, acc ->
      if (start + i not in input) do
        acc
      else
        acc + find_combinations(input, start + i, max)
      end
    end)
  end

  defp max_jolts(input) do
    Enum.max(input) + 3
  end

  def part2(input) do
    LruCache.start_link(:my_cache, 10000)
    input = input |> preprocess()
    find_combinations(input, 0, Enum.max(input))
  end

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(& &1 == "")
    |> Enum.map(&String.to_integer/1)
  end
end
