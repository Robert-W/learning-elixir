filepath = "./io-files-data.txt"
# Open a file and write to it, this will wipe the contents of the file if it
# already exists, which is perfect for this example
{:ok , file } = File.open(filepath, [:write])

# By default, files open in Binary mode, so we rear/write with binwrite and
# binread
IO.binwrite(file, "hello world")

# Close the file and read it
File.close(file)

# This method of reading returns a tuple, so we have to inspect the results
# since String.Chars protocol is not implemented for the Tuple Type
# You would use this when you want to pattern match on the read result and
# handle the ok and error versions separately
# e.g.
# case File.read("path/to/file") do
#   {:ok, body} -> # work with the body here
#   {:error, reason} -> handle the erorr caused by reason
# end
IO.puts inspect File.read(filepath)

# This version pulls the body out or raises an exception. You should always use
# the File methods ending in ! unless you want to handle the error outcome. If
# you dont and you use {:ok, body} = File.read("path/to/file") and it errors,
# the error will be about the matching failing and hide the real error
IO.puts File.read!(filepath)

# Use path when dealing with filepaths. it handles OS differences transparently
# under the hood.
IO.puts Path.join("foo", "bar")
IO.puts Path.expand("~/projects")

# iodata and chardata
name = "Mary"

# This results in copying Mary, which is ok, but bad for large strings
IO.puts("Hello " <> name <> "!")

# This does not copy, it creates a list called either iodata or chardata
IO.puts ["Hello ", name, "!"]

# This can be useful when writing to files, we can join them and create a new
# string, or we can intersperse them.
IO.puts Enum.join(["apple", "banana", "lemon"], ",")
IO.puts Enum.intersperse(["apple", "banana", "lemon"], ",")
