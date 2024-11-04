# Attach documentation to the module attributes
defmodule MyApp.Hello do
  @moduledoc """
  This is the Hello module.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Says hello to the given `name`.

  Returns `:ok`

  ## Examples

    iex> MyApp.Hello.world(:john)
    :ok

  """
  @doc since: "1.3.0"
  def world(name) do
    IO.puts("Hello #{name}")
  end

  # Documenting the function argumnets can be done by specifying a proper name in
  # a function head before the implementation
  def size(map_with_size)

  def size(%{size: size}) do
    size
  end

  # Two ways to mark something as deprecated, one shows up in docs only, the
  # other can emit a warning in the code when used
  @doc deprecated: "Use Foo.Bar/2 instead"

  # This one emits the warning in code
  @deprecated "Use Foo.Bar/2 instead"
end

# Hide a module from documentation
defmodule MyApp.Hidden do
  @moduledoc false

  @doc """
  This function won't be listed in the docs
  """
  dev hidden_function do
    :ok
  end
end

# Hide a function from documentation
defmodule MyApp.Sample do
  @doc false
  def add(a, b), do: a + b
end
