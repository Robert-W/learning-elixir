#  Sigils start with the tilde (~) character which is followed by either a
# single lower-case letter or one or more upper-case letters, and then a
# delimiter. Optional modifiers are added after the final delimiter.

# Regex is a common sigil
regex = ~r/foo|bar/
IO.puts("foo" =~ regex)
IO.puts("bat" =~ regex)

# Elixir uses perl compatible regualr expressions, and we can even use modifiers
IO.puts("HELLO" =~ ~r/hello/)
IO.puts("HELLO" =~ ~r/hello/i)

# String sigils
IO.puts(~s(this is a string with "double" quotes, not 'single' ones))

# Charlist sigils
# one example [?c, ?a, ?t] will output ~c"cat"
IO.puts(~c(this is a char list containing "double quotes"))

# Word list sigils can generate a list of words
IO.puts(inspect(~w(foo bar bat)))

# Word list accepts c, s, and a modifiers to convert the output to a specific
# datatype. E.g. charlists, strings, or atoms. The default is a string
IO.puts(inspect(~w(foo bar bat)a))

# Uppercase sigils do not perform interpolation or escaping
# ~s(String with escape codes \x26 #{"inter" <> "polation"}) returns
# -- "String with escape codes & interpolation"
# ~S(String without escape codes \x26 without #{interpolation}) returns
# "String without escape codes \\x26 without \#{interpolation}"

# Uppercase sigils can be useful in heredocs where we dont want to think about
# escaping all the characters in our documentation
# @doc """
# Convert double to single quotes
#
# ## Examples
#
#   iex> convert("\\\"foo\\\"")
#   "'foo'"
# """
#
# # Using an uppercase sigil
# @doc ~S"""
# Convert double to single quotes
#
# ## Examples
#
#   iex> convert("\"foo\"")
#   "'foo'"
# """

# Sigils for date and time
# year month day
date = ~D[2019-10-31]
IO.puts("Year #{date.year}, #{date.month} #{date.day}")
# hour, minute, second, microsecond
time = ~T[23:00:07.0]
IO.puts("#{time.hour} #{time.minute} #{time.second}")
# NaiveDateTime does both
datetime = ~N[2019-10-31 23:00:07]
IO.puts("#{datetime.year} #{datetime.month} #{datetime.day} #{datetime.hour} #{datetime.minute} #{datetime.second}")
# UTC DateTime
utc = ~U[2019-10-31 19:59:03Z]
IO.puts("Timezone: #{utc.time_zone}")

# Create our own Sigil at ~i to return an integer with an optional modifier
defmodule MySigils do
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string)
end

# The following wont work when running this from elixir sigils.exs, bit you can
# run iex sigils.exs, then in the interactive shell run the commands below
#
# import MySigils
#
# ~i(13)
# ~i(42)n
