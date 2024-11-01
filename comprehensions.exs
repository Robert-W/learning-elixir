# Map a list of integers into their squared values
IO.puts(inspect(for n <- [1, 2, 3, 4], do: n * n))

# Comprehensions are made up of three parts, generators, filters, and
# collectables. In the above, n <- [1, 2, 3, 4] is the generator. Any enumerable
# can be passed in as a generator
IO.puts(inspect(for n <- 1..4, do: n * n))

# Filters can be passed on the left hand side, all non matching patterns are
# ignored. Lets write comprehension for a keyword list
values = [good: 1, good: 2, bad: 3, good: 4]
IO.puts(inspect(for {:good, n} <- values, do: n * n))

# You can also use filters to select some particular elements
IO.puts(inspect(for n <- 0..5, rem(n, 3) == 0, do: n * n))

# Comprehensions discard all elements where the filter expression returns false
# or nil. Comprehension can provide a concise representation

dirs = ["../dotfiles"]

for dir <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file),
    File.regular?(path) do
  IO.puts("#{path}: #{inspect(File.stat!(path).size)} bytes")
end

# We can also use multiple generators to calculate the cartesian product of two
# lists.
IO.puts(inspect(for i <- [:a, :b, :c], j <- [1, 2], do: {i, j}))

# You can also use genertaors to comprehend over bitstring streams. Take the
# list of pixels below from a binary with their RGB values and convert them into
# tuples of three elements each
pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
IO.puts(inspect(for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}))

# We can use the :into operator to force comprehension results into a structure
# other than a list
IO.puts(inspect(for <<c <- " hello world ">>, c != ?\s, into: "", do: <<c>>))

# Anything that inmplements the collectible protocol can be used in :into
# A common use case is to put things into a Map
IO.puts(inspect(for {key, val} <- %{"a" => 1, "b" => 2}, into: %{}, do: {key, val * val}))

# Streams are also collectibles, so we can do this example (careful it will lock
# up the terminal, you'll need to use Ctrl+C to get out)
steram = IO.stream(:stdio, :line)
for line <- stream, into: stream do
  String.upcase(line) <> "\n"
end

# See the docs for more https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1
