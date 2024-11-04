# Execute the debugger by doing iex --dbg pry dbg.exs
__ENV__.file
|> String.split("/", trim: true)
|> List.last()
|> File.exists?()
|> dbg()
