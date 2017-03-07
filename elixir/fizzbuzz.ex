defmodule Fizzbuzz do
    def of(n) do
        Enum.map(1..n, &transform_number/1)
    end

    defp transform_number(n) when rem(n, 3) == 0 and rem(n, 5) == 0, do: "FizzBuzz"
    defp transform_number(n) when rem(n, 3) == 0, do: "Fizz"
    defp transform_number(n) when rem(n, 5) == 0, do: "Buzz"
    defp transform_number(n), do: n
end
