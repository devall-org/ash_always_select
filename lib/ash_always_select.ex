defmodule AshAlwaysSelect do
  @ash_always_select %Spark.Dsl.Section{
    name: :ash_always_select,
    describe: """
    Set always_select? to true for all attributes.
    """,
    examples: [
      """
      always_select do
        except [:list_big_attribute_here]
      end
      """
    ],
    schema: [
      except: [
        type: {:wrap_list, :atom},
        required: false,
        default: [],
        doc: "List of attributes to exclude from always_select."
      ]
    ],
    entities: []
  }

  use Spark.Dsl.Extension,
    sections: [@ash_always_select],
    transformers: [AshAlwaysSelect.Transformer]
end
