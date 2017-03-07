defmodule Outer.Inner do
    def inner_func do
        "inner"
    end
end

defmodule Outer do
    # alias Outer.Inner   # import the module as Inner by default
    alias Outer.Inner, as: OuterInner

    require Logger  # special module which must be required

    def outer_func do
        Logger.info "outer"
    end
end

defmodule Greeter do
    @moduledoc """
    ## Markdown header
    """

    @default_greeting Time.utc_now  # stays the same after compilation

    def greet(name \\ @default_greeting) do
        IO.puts "Hello, #{name}!"
    end
end