defmodule Recursion do
  def print_many_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_many_times(msg, n - 1)
  end

  def print_many_times(_msg, 0) do
    :ok
  end
end

defmodule Math do
  # Sum list is like a reduce function
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    IO.puts("Result #{accumulator}")
  end

  # This is a way to do a map operation
  def double([head | tail]) do
    [head * 2 | double(tail)]
  end

  def double([]) do
    []
  end

  def triple(list) do
    Enum.map(list, &(&1 * 3))
  end
end

Recursion.print_many_times("Hello", 3)
Math.sum_list([1, 2, 3, 4], 0)
Math.double([1, 2, 3])
