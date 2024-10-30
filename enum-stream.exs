# helper function to print charlist
print = fn list -> IO.puts(inspect(list, charlist: :as_list)) end

# Simple Map function
print.(Enum.map([1, 2, 3], fn x -> x * 2 end))

# Map over a map
print.(Enum.map(%{ 1 => 2, 3 => 4 }, fn {k, v} -> k * v end))

# Using ranges
print.(Enum.map(1..3, fn x -> x * 2 end))

# Range on reduce with a capture
print.(Enum.reduce(1..3, 0, &+/2))

# Range on reduce without a capture
print.(Enum.reduce(1..3, 0, fn a, acc ->
  a + acc
end))

# All functions in Enum are eager, meaning when you chain multiple operations
# it's going to generate an intermediate list until the result is reached
odd = fn x -> rem(x, 2) != 0 end

# This creates an intermediate list for map and filter
IO.puts 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd) |> Enum.sum()

# We can do this lazily and use streams, this builds a series of computations
# that are invoked only when we pass the underlying stream to the Enum module
IO.puts 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd) |> Enum.sum()

# Some stream functions create streams, be careful, calling Enum.map on this
# would loop forever
stream = Stream.cycle([1, 2, 3])
print.(Enum.take(stream, 10))

# You can use Stream.unfold to generate a list of values
stream = Stream.unfold("hello", &String.next_codepoint/1)
print.(Enum.take(stream, 3))

# You can use streams to read files
stream = File.stream!("./data.txt") |> Stream.map(&String.trim(&1, "\n"))
print.(Enum.take(stream, 3))

# See more with the cheatsheet
# https://hexdocs.pm/elixir/enum-cheat.html
