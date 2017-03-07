defmodule Asl do
    # keyword list: [fn: params_count, ...]
    import String, only: [upcase: 1, split: 2, strip: 1]

    defp is_prop(str), do: true

    def transform_csv(csv_line) when is_prop(str) do
        csv_line
        |> upcase
        |> split(",")
        |> Enum.map(&strip/1)
        |> Enum.join(" ")
    end
end