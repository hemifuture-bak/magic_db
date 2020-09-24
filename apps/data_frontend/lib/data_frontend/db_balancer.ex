defmodule DataFrontend.DbBalancer do
  use GenServer

  # APIs
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def get_node() do
    GenServer.call(__MODULE__, :get_node)
  end

  # GenServer callbacks
  @impl true
  def init(_args) do
    {:ok,
     %{
       loads: []
     }}
  end

  @impl true
  def handle_call(:get_node, _from, state = %{loads: []}) do {:reply, nil, state} end
  def handle_call(
        :get_node,
        _from,
        state = %{
          loads: loads
        }
      ) do
    case loads do
      [] -> {:reply, nil, state}
      _ ->
        {min_n, _} = Enum.min_by(loads, fn {_, count} -> count end, fn -> nil end)
        new_loads = Enum.map(loads, fn load = {n, c} ->
          if min_n == n do
            {n, c + 1}
          else
            load
          end
        end)

        {:reply, min_n, %{state | loads: new_loads}}
    end

  end
end
