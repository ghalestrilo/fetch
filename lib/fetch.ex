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

  @spec fetch(url :: String.t()) :: {atom, %{atom => [String.t()]}}
  def fetch(url, data_to_retrieve \\ [{"img", "src", :assets}, {"a", "href", :links}]) do
    tags_to_extract = data_to_retrieve |> Enum.map(fn {tagname, _, _} -> tagname end)

    with {:ok, html} <- get_body(url),
         {:ok, tagdata} <- extract_tags(html, tags_to_extract) do
      result =
        data_to_retrieve
        |> Enum.map(fn {tagname, attrname, fieldname} ->
          {fieldname, tagdata |> Map.get(tagname) |> Enum.map(&get_attr(&1, attrname))}
        end)
        |> Map.new()
        |> IO.inspect()

      {:ok, result}
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
