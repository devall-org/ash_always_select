defmodule AshAlwaysSelect.Transformer do
  use Spark.Dsl.Transformer

  alias Spark.Dsl.Transformer

  def after?(Ash.Resource.Transformers.BelongsToAttribute), do: true
  def after?(_), do: false

  def transform(dsl_state) do
    except_list = Transformer.get_option(dsl_state, [:always_select], :except, [])

    dsl_state
    |> Transformer.get_entities([:attributes])
    |> Enum.reject(fn attr -> attr.name in except_list end)
    |> Enum.map(fn attr -> %Ash.Resource.Attribute{attr | always_select?: true} end)
    |> Enum.reduce(dsl_state, fn new_attr, dsl_state ->
      Transformer.replace_entity(
        dsl_state,
        [:attributes],
        new_attr,
        &(&1.name == new_attr.name)
      )
    end)
    |> then(fn dsl_state -> {:ok, dsl_state} end)
  end
end
