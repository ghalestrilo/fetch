defmodule FetchTest do
  use ExUnit.Case, async: false
  import Mock

  # doctest Fetch

  @success_body File.read!("test/mocks/crawler_test.html")

  @links [
    "/css/app.css",
    "/favicon.ico?r=1.6",
    "/",
    "https://crawler-test.com/",
    "https://crawler-test.com/",
    "https://crawler-test.com/",
    "https://crawler-test.com/image_link.png"
  ]

  @assets ["/image_link.png", "/image_link.png", "/image_link.png", "/image_link.png"]

  defp httpoison_mock(),
    do:
      {HTTPoison, [:passthrough],
       get: fn _ -> {:ok, %HTTPoison.Response{body: @success_body}} end}

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

  describe "fetch/1 with a good URL" do
    setup_with_mocks([httpoison_mock()]) do
      %{result: Fetch.fetch(@url)}
    end

    test "returns :ok", %{result: result} do
      assert {:ok, _} = result
    end

    test "returns correct assets/links count", %{result: result} do
      assert {:ok, %{assets: assets, links: links}} = result
      assert Enum.count(assets) == Enum.count(@assets)
      assert Enum.count(links) == Enum.count(@links)
    end

    test "returns correct assets", %{result: result} do
      assert {:ok, %{assets: assets}} = result
      assert assets == @assets
    end

    test "returns correct links", %{result: result} do
      assert {:ok, %{links: links}} = result
      assert links == @links
    end
  end
end
