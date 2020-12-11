defmodule Advent.Year2020.Day07 do
  def part1(input) do
    input
    |> preprocess()
    |> build_tree()
    |> resolve(["shiny gold"], [], [])
  end

  def part2(input) do
    input
    |> preprocess()
    |> build_tree()
    |> resolve2("shiny gold")
  end

  def resolve2(tree, bag) do
    tree
    |> Map.get(bag)
    |> Enum.reduce(0, fn
      nil, acc -> acc
      {v, k}, acc ->
      acc + v + resolve2(tree, k) * v
    end)
  end

  defp resolve(tree, [], counted, counter) do
    counter
    |> Enum.uniq()
    |> Enum.count()
  end

  defp resolve(tree, [bag | tail], counted, counter) do
    list =
      tree
      |> Map.keys()
      |> Enum.filter(fn name ->
        tree
        |> Map.get(name)
        |> case do
          [nil] -> false
          bags -> Enum.any?(bags, fn {_, v} ->
            v == bag and v not in counted
          end)
        end
      end)
      |> Enum.uniq()

    new_counter = list ++ counter
    new_list = Enum.uniq(tail ++ list -- counted)
    new_counted = Enum.uniq([bag | counted])
    resolve(tree, new_list, new_counted, new_counter)
  end

  defp build_tree(rules) do
    rules
    |> Enum.reduce(%{}, fn rule, tree ->
      Map.merge(tree, build_root(rule))
    end)
    |> build_nodes()
    |> Enum.reduce(%{}, fn {key, val}, acc -> Map.put(acc, key, val) end)
  end

  defp build_root(rule) do
    [rule_name, tail] =
      rule
      |> String.split(" contain ")
    key = rule_name |> String.replace(" bags", "")
    value =
      tail
      |> String.replace("bag,", "bags,")
      |> String.replace("bag.", "bags,")
      |> String.replace("bags.", "bags,")
      |> String.replace(" bags, ", ",")
      |> String.replace(" bags", "")
      |> String.split(",")
      |> Enum.reject(& &1 == "")
    %{key => value}
  end

  defp build_nodes(tree) do
    values =
      tree
      |> Map.to_list()
      |> Enum.map(fn {node,  value} ->
        {node, Enum.map(value, fn bag ->
          [quantity | tail] = String.split(bag, " ")
          case quantity do
            "no" -> nil
            number -> {String.to_integer(number), Enum.join(tail, " ")}
          end
        end)}
      end)
  end

  defp preprocess(input) do
    input
    |> String.split("\n")
    |> Enum.reject(& &1 == "")
  end
end
