defmodule Advent.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Advent.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "0.5.1"},
      {:math, "0.5.0"},
      {:jason, "1.2.2"},
      {:lru_cache, "~> 0.1.0"},
      {:mix_test_watch, "1.0.2", runtime: false}
    ]
  end
end
