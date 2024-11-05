defmodule Math do
  @moduledoc """
  Provides Math related shenanigans

  ## Examples
    iex> Math.sum(1, 2)
    3
  """

  @doc """
  Calculates the sum of two numbers
  """
  def sum(a, b), do: a + b
end

defmodule MyServer do
  # This is an example of temporary storage. This is injected into the module
  # during compilation and will be stripped out.
  @service URI.parse("https://www.example.com")

  def status() do
    IO.puts inspect @service
  end

  # This is not ideal as the attribute gets compiled multiple times
  # def some_func(), do: IO.puts @service
  # def another_func(), do: IO.puts @service

  # You should do this instead, it will only compile the attribute once
  # def some_func(), do: IO.puts get_service()
  # def another_func(), do: IO.puts get_service()
  # defp get_service, do: @service
end
