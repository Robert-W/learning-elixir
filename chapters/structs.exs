defmodule User do
  # This specifies two fields with default values
  defstruct name: "John", age: 27
end

defmodule Product do
  # This specifies a name field with no default value, so the default value ends
  # up being nil
  defstruct [:name]
end

defmodule UserTwo do
  # You can define both types, some fields with defaults and others not. However
  # order matters here, the fields with no default values must be first.
  # defstruct: [name: "John", age: 27, :email] would raise a syntax error
  defstruct [:email, name: "John", age: 27]
end

defmodule Car do
  # This enforces that when you create a car, a make is provided
  @enforce_keys [:make]
  defstruct [:model, :make]
end



# This code won't work, we cant access the struct User in the same context that
# defines it. You can run `iex structs.exs` to run the following examples
# iex> %User{}
# %User{age: 27, name: "John"}
# iex> %User{ name: "Jane" }
# %User{age: 27, name: "Jane"}
# iex> %User{oops: :field}
# ** (KeyError) key :oops not found expanding struct: User.__struct__/1
