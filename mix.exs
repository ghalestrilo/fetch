defmodule Fetch.MixProject do
  use Mix.Project

  def project do
    [
      app: :fetch,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.32.0"},
      {:jason, "~> 1.2"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
