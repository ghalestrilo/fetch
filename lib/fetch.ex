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
  def fetch(url) do
    tags = [{"img", "src"}, {"a", "ref"}]

    with {:ok, html} <- get_body(url),
         {:ok, result} <- extract_tags(html, ["img", "a"]) do
      %{"a" => a_tags, "img" => img_tags} = result

      assets = img_tags |> Enum.map(&get_attr(&1, "src"))
      links = a_tags |> Enum.map(&get_attr(&1, "href"))

      {:ok, %{assets: assets, links: links}}
    else
      error -> error |> IO.inspect(label: "error")
    end
  end

  def get_attr({_tag, attrs}, attrname) do
    attrs |> Map.new() |> Map.get(attrname, "")
  end

  @spec extract_tags(data :: String.t(), tags :: [String.t()]) :: {atom, %{String.t() => [any]}}
  def extract_tags(data, tags) do
    result =
      tags
      |> Enum.map(fn tag ->
        {
          tag,
          Floki.find(data, tag)
          |> Enum.map(fn {tag, attrs, _children} ->
            {tag, attrs}
          end)
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
