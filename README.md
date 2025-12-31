# AshAlwaysSelect (DEPRECATED)

> ⚠️ **IMPORTANT: This package is deprecated and should not be used in any project.**

## 🛑 Why this package is deprecated

This extension was created during an early learning phase of Ash Framework based on a misunderstanding of its core selection logic. While it seems convenient for prototypes, it introduces several critical issues:

1. **Implicit Dependencies:** It forces all attributes to be selected by default. This leads to code that breaks unexpectedly if the extension is later removed or if specific fields are excluded.
2. **Performance Degradation:** It bypasses Ash's optimized data fetching by always loading every attribute, including large text fields or sensitive data, which can significantly slow down your application.
3. **Anti-pattern:** Ash is designed around "explicit selection" for a reason. Forcing global selection goes against the framework's architecture.

## Installation (Not Recommended)

Add `ash_always_select` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ash_always_select, "~> 0.2.0"}
  ]
end
```

## Purpose

When creating applications where speed is not critical, such as toy projects or prototypes, listing attributes to select in read actions and calculations can be cumbersome.
This Ash extension ensures that all attributes are always selected.

## Usage

```elixir
defmodule Post do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Postgres,
    extensions: [AshAlwaysSelect]

  attributes do
    uuid_primary_key :id
    attribute :title, :string
    attribute :content, :string
  end

  always_select do
    except [:content]
  end
end
```

For the example above, `title` will have `always_select?: true`.

## License

MIT