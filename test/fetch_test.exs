defmodule FetchTest do
  use ExUnit.Case, async: false

  doctest Fetch

  @success_body File.read!("test/mocks/crawler_test.html")

  describe "get_body/2" do
    test "passes" do
      # assert {:ok, @success_resp} == Fetch.get_body(@url)
      :ok
    end
  end

  describe "extract_tags/2 with good params" do
    test "returns exactly the expected count of tags" do
      assert {:ok, divs} = Fetch.extract_tags(@success_body, ["div"])
      divcount = divs |> Map.get("div") |> Enum.count()
      assert divcount == 10
    end

    test "returns the correct tag" do
      assert {:ok, _divs} = @success_body |> Fetch.extract_tags(["iframe"])
    end
  end

  describe "fetch/1" do
    test "passes" do
      :ok
    end
  end
end
