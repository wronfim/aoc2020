defmodule Advent.Year2020.Day09 do
  def part1(input, preamble) do
    input
    |> preprocess()
    |> find_invalid(preamble, preamble)
  end

  defp find_invalid(list, pos, preamble) do
    number = Enum.at(list, pos)
    prev_numbers = get_prev_list(list, pos, preamble)
    with {_n1, _n2, true} <- find_sum(prev_numbers, number) do
      find_invalid(list, pos+1, preamble)
    end
  end

  defp get_prev_list(list, pos, preamble) do
    pos-preamble..pos-1
    |> Enum.map(& Enum.at(list, &1))
  end

  defp find_sum([], number), do: number

  defp find_sum([n1 | tail], number) do
    case Enum.find(tail, fn n2 -> n1 + n2 == number end) do
      nil -> find_sum(tail, number)
      n2 -> {n1, n2, true}
    end
  end

  defp find_set(list, number) do
    case take_til_zero(list, number, []) do
      :not_found -> find_set(List.delete_at(list, 0), number)
      res -> Enum.min(res) + Enum.max(res)
    end
  end

  defp take_til_zero([], _, _), do: :not_found
  defp take_til_zero(_, 0, numbers), do: numbers
  defp take_til_zero([n1 | tail], acc, numbers) do
    if (acc < 0) do
      :not_found
    else
      take_til_zero(tail, acc - n1, [n1 | numbers])
    end
  end

  def part2(input, target) do
    input
    |> preprocess()
    |> find_set(target)
  end

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(& &1 == "")
    |> Enum.map(&String.to_integer/1)
  end
end
