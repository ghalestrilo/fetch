# Fetch

This program allows you to retrieve data from HTTP webpages. 
It does so through the fetch/1 method, which receives an URL an returns a map containing links and assets of that page.
Its overload, fetch/2, allows you to parameterize which tags and attributes you wish to retrieve, as well as naming the resulting array field on the output map.

## Dependencies

This library depends on [HTTPoison](https://github.com/edgurgel/httpoison) for HTTP requests and [Floki](https://github.com/philss/floki) for HTTP parsing, as well as Mock and Jason for testing.

## Running

Before running you must install the project dependencies. You can do so with

```bash
$ mix deps.get
$ mix deps.compile
```

Then, you can start an IEx session with `iex -S mix`, and running the method 

```elixir
Fetch.fetch("http://...")
#  {:ok, %{ links: [...], assets: [...] }

Fetch.fetch("http://...", [{"img", "src", :assets}])
#  {:ok, %{ assets: [...] }
```

##
