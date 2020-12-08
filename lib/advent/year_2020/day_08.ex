defmodule Advent.Year2020.Day08 do
  def part1(input) do
    input
    |> preprocess()
    |> run(0, {0, %{}})
  end

  def part2(input) do
    data = preprocess(input)

    data
    |> run(0, {0, %{}})
    |> swap_nop_jmp(data)
  end

  defp run(instructions, pos, {acc, executed}) do
    pos_key = Integer.to_string(pos)
    with nil <- Map.get(executed, pos_key),
         {cmd, arg} <- Enum.at(instructions, pos) do
      new_executed = Map.put(executed, pos_key, true)
      {new_pos, new_acc} = execute({cmd, arg}, pos, acc)
      run(instructions, new_pos, {new_acc, new_executed})
    else
      true -> {:infinite_loop, acc}
      _instruction_not_found -> acc
    end
  end

  defp execute({"nop", _arg}, pos, acc), do: {pos+1, acc}
  defp execute({"acc", arg}, pos, acc), do: {pos+1, acc+arg}
  defp execute({"jmp", arg}, pos, acc), do: {pos+arg, acc}

  defp swap_nop_jmp({:infinite_loop, _acc} = acc, input) do
    instructions_to_replace =
      input
      |> Enum.with_index()
      |> Enum.reject(fn {{cmd, _}, _pos} -> cmd == "acc" end)

      try_again(acc, input, instructions_to_replace)
  end

  defp swap_nop_jmp(acc, _input), do: acc

  defp try_again(acc, _input, []), do: acc

  defp try_again({:infinite_loop, _acc}, input, [{{_cmd, arg}, pos} | tail]) do
    input
    |> Enum.with_index()
    |> Enum.map(fn
      {{"jmp", ^arg}, ^pos} -> {"nop", arg}
      {{"nop", ^arg}, ^pos} -> {"jmp", arg}
      {instruction, _pos} -> instruction
    end)
    |> run(0, {0, %{}})
    |> try_again(input, tail)
  end

  defp try_again(acc, _input, _), do: acc

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(& &1 == "")
    |> Enum.map(& String.split(&1, " "))
    |> Enum.map(fn [cmd, arg] -> {cmd, String.to_integer(arg)} end)
  end
end
