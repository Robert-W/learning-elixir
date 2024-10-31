# This works in my own apps, because I can easily extend it. However, if this
# were a library, consumers of it could not easily extend it, so this  is not
# the best way to achieve this.
# defmodule Utility do
#   def type(value) when is_binary(value), do: "string"
#   def type(value) when is_integer(value), do: "integer"
# end

# Protocols help here because protocols allow us to extend the original behavior
# for as many data types as we need. That's because dispatching on a protocol is
# available to any data type that implements the protocol. Here's how we can use
# protocols in the above example.
defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

# Implement a protocol that any data structure that returns a precomputed size.
defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: BitString do
  def size(data), do: byte_size(data)
end

defimpl Size, for: Map do
  def size(data), do: map_size(data)
end

defimpl Size, for: Tuple do
  def size(data), do: tuple_size(data)
end

# MapSet is a struct, so it does not share protocol implementations with Maps
# even though structs are maps.
defimpl Size, for: MapSet do
  def size(data), do: MapSet.size(data)
end

# You can do this for your own Structs
defmodule User do
  defstruct [:name, :age]
end

defimpl Size, for: User do
  def size(_user), do: 2
end

# Using the Any protocol
defimpl Size, for: Any do
  def size(_), do: 0
end

# We can have another module derive the Size protocol and it will use the Any
# implementation. Invoking Size.size(%OtherUser{}) will return 0 since that is
# how we implemented Any.
defmodule OtherUser do
  @derive [Size]
  defstruct [:name, :age]
end

# This can also be set on the protocol implementation itself
# defprotocol Size do
#   @fallback_to_any true
#   def size(data)
# end
