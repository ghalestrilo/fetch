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

  @spec extract_tags(data :: String.t(), tags :: [atom]) :: {atom, [any]}
  def extract_tags(_data, _tags) do
    {:ok, []}
  end

  @spec get_body(url :: String.t()) :: {atom, String.t()}
  def get_body(_url) do
    {:ok, ""}
  end
end
