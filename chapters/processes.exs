# Get a reference to the current process
main_process = self()

# Spawn a new process that sends a message to the main processes mailbox
spawn(fn -> send(main_process, {:hello, self()}) end)

# Read the message
receive do
  {:hello, pid} ->
    IO.puts("Got Hello from #{inspect(pid)}")
end

# Tasks build on top of spawn functiond to provide better error reports and
# introspection
IO.puts inspect Task.start(fn -> raise "oops" end)

# Using agents to track state
{:ok, pid} = Agent.start_link(fn -> %{} end)

# Update some state then fetch that state
Agent.update(pid, fn map -> Map.put(map, :hello, "world") end)
IO.puts Agent.get(pid, fn map -> Map.get(map, :hello) end)
