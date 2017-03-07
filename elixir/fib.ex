defmodule Fibonacci do
    def of(1), do: 1
    def of(2), do: 2
    def of(n) when is_number(n) and n > 0, do: of(n - 1) + of(n - 2)

    def of(str) when is_bitstring(str) do
        of(String.to_integer(str))
    end

    def of(list) when is_list(list) do
        Enum.map(list, &of/1)
    end
end
