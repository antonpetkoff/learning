defmodule Playground do
  @moduledoc """
  Documentation for Playground.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Playground.hello
      :world

  """
  def hello do
    :world
  end

  def main(list) do
    list
    |> Enum.map(&IO.puts/1)    
  end

end
