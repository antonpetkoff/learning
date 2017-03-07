
defmodule Times do
    # def double(x) do: x * 2 # handle edge case

    def double(x) do
        2 * x
    end

    def triple(x) do
        3 * x
    end

    def pow(_, 0) do
        1
    end

    def pow(n, power) do
        n * pow(n, power - 1)
    end

    def inc(a, b \\ 1) do
        a + b
    end
end
