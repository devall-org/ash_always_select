# AshAlwaysSelect

Set always_select? to true for all attributes.

## Installation

Add `ash_always_select` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ash_always_select, "~> 0.1.0"}
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