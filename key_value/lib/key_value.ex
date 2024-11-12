defmodule KeyValue do
  @moduledoc """
  Documentation for `KeyValue`.
  """
  use Application

  @impl true
  def start(_type, _args) do
    KeyValue.Supervisor.start_link(name: KeyValue.Supervisor)
  end
end
