# Fetch

This program allows you to retrieve data from HTTP webpages. 
It does so through the fetch/1 method, which receives an URL an returns a map containing links and assets of that page.
Its overload, fetch/2, allows you to parameterize which tags and attributes you wish to retrieve, as well as naming the resulting array field on the output map.

## Dependencies

This library depends on [HTTPoison](https://github.com/edgurgel/httpoison) for HTTP requests and [Floki](https://github.com/philss/floki) for HTTP parsing, as well as Mock and Jason for testing.

## Installation

Before running you must install the project dependencies. You can do so with

```bash
$ mix deps.get
$ mix deps.compile
```

## Running

Once install, you can run the `fetch/1` method through an IEx session. Start the session in your terminal with `iex -S mix`, and try the following command inside it 

```elixir
Fetch.fetch("http://...")
#  {:ok, %{ links: [...], assets: [...] }

Fetch.fetch("http://...", [{"img", "src", :assets}])
#  {:ok, %{ assets: [...] }
```

## Assumptions

1. It is the desired behavior for `fetch/1` to include all link/asset duplicates
2. In the future, developers may wish to extract attribute from other tags.
3. URLs from tags don't have to be validated
4. There's no need at the moment for a controller to access this method, or even for somehow rendering its output

## Roadmap

Improvements I would've made if there was more time:

1. **Sad-path testing:** right now, the only test-covered flow is `{:ok, _}`, for all functions. Among other exception scenarios, these are important to test:
   - A bad URL is passed
   - Payload not HTML (requesting from an API, from instance)
   - Broken HTML payload
2. **Comments and overall code clarity:** The code is ok in terms of structure, but adding comments, naming a couple lambdas and other small adjustments would make it clearer 
3. **Split Modules:** The solution was coded completely inside the same module. While not a problem for a module this size, given that it will run in a server as part of a larger app, it may grow larger towards the future. With this in mind, avoiding unnecesary coupling is a good idea.
4. **Types:** Some basic typing was implemented for the `Fetch` module methods, but some of them use `any()` or type constructs that could be extracted and named.
