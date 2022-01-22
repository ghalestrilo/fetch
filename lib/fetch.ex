defmodule Fetch do
  @moduledoc """
  This module implements methods to retrieve pages from the web
  and query their HTML content
  """

  @doc """
  ## Examples
      iex> Fetch.fetch("http://zen.github.io")
      {
        :ok,
        %{
        assets: [],
        links: [
          # "https://githubstatus.com",
          # "https://twitter.com/githubstatus",
          # "/",
          # "/"
        ]
      }
      }
  """

  @spec fetch(url :: String.t()) :: {atom, %{assets: [String.t()], links: [String.t()]}}
  def fetch(_url) do
    {:ok, %{assets: [], links: []}}
  end

  @spec extract_tags(data :: String.t(), tags :: [String.t()]) :: {atom, %{String.t() => [any]}}
  def extract_tags(data, tags) do
    result =
      tags
      |> Enum.map(fn tag ->
        {
          tag,
          Floki.find(data, tag)
          |> Enum.map(fn {tag, attrs, _children} -> {tag, attrs} end)
        }
      end)
      |> Map.new()

    {:ok, result}
  end

  @spec get_body(url :: String.t()) :: {atom, String.t()}
  def get_body(url) do
    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(url) do
      {:ok, body}
    else
      error -> error
    end
  end
end
