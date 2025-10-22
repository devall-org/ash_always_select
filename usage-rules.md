# Rules for working with AshAlwaysSelect

## Purpose

AshAlwaysSelect is an Ash extension that automatically sets `always_select?: true` on all attributes. It reduces the overhead of explicitly listing attributes to select in read actions and calculations during prototyping and early development stages.

## When to Use

- Prototypes or toy projects where performance is not critical
- Early development stages where rapid iteration is needed
- Small resources where all attributes are typically needed

## When NOT to Use

- Production applications where performance is critical
- Resources with large data volumes
- Resources containing sensitive information (even with field policies, explicit select is safer)

## Usage

Add the extension to your resource:

```elixir
defmodule MyApp.Post do
  use Ash.Resource,
    domain: MyApp.Blog,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAlwaysSelect]

  attributes do
    uuid_primary_key :id
    attribute :title, :string
    attribute :body, :text
    attribute :metadata, :map
  end
end
```

### Excluding Attributes

Use the `except` option to exclude specific attributes:

```elixir
defmodule MyApp.Post do
  use Ash.Resource,
    domain: MyApp.Blog,
    extensions: [AshAlwaysSelect]

  attributes do
    uuid_primary_key :id
    attribute :title, :string
    attribute :body, :text
    attribute :large_content, :binary  # Large data
  end

  always_select do
    except [:large_content]
  end
end
```

In the example above, all attributes except `:large_content` will have `always_select?: true`.

## Best Practices

- Exclude large binary or text fields using `except`
- Consider refactoring to explicit selects before moving to production
- Useful when calculations frequently use many attributes
