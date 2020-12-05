defmodule Advent.Year2020.Day04 do
  @fields ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def part1(input) do
    input
    |> preprocess()
    |> Enum.filter(&validate_required_fields/1)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> preprocess()
    |> Enum.filter(&validate_required_fields/1)
    |> Enum.filter(&validate_fields/1)
    |> Enum.count()
  end

  defp validate_fields(passport) do
    @fields
    |> Enum.map(&validate_field(&1, passport))
    |> Enum.all?(& &1)
  end

  defp validate_year_range(value, from, to) do
    year = String.to_integer(value)
    String.length(value) == 4 and (year >= from and year <= to)
  end

  defp validate_field("byr", %{"byr" => year}), do: validate_year_range(year, 1920, 2002)
  defp validate_field("iyr", %{"iyr" => year}), do: validate_year_range(year, 2010, 2020)
  defp validate_field("eyr", %{"eyr" => year}), do: validate_year_range(year, 2020, 2030)

  defp validate_field("hcl", %{"hcl" => value}),
    do: String.length(value) == 7 and Regex.match?(~r/#[0-9 | a-f]{6}/, value)

  defp validate_field("ecl", %{"ecl" => value}),
    do: value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  defp validate_field("pid", %{"pid" => value}),
    do: String.length(value) == 9 and match?({_number, ""}, Integer.parse(value))

  defp validate_field("hgt", %{"hgt" => value}) do
    case Integer.parse(value) do
      {height, "cm"} -> height >= 150 and height <= 193
      {height, "in"} -> height >= 59 and height <= 76
      _ -> false
    end
  end

  defp validate_required_fields(passport) do
    @fields
    |> Enum.map(&Map.has_key?(passport, &1))
    |> Enum.all?(& &1)
  end

  defp preprocess(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.replace(&1, "\n", " "))
    |> Enum.map(fn passport ->
      passport
      |> String.split(" ")
      |> Enum.map(&String.split(&1, ":"))
      |> Enum.reject(&(&1 == [""]))
      |> Enum.map(&List.to_tuple/1)
      |> Enum.reduce(%{}, fn {key, val}, acc ->
        Map.put(acc, key, val)
      end)
    end)
  end
end
