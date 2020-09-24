defmodule DataFrontend.Contact do
  use GenServer

  # APIs
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def register(node, role) do
    # IO.inspect([node, role])
    GenServer.call(__MODULE__, {:register, node, role})
  end

  def db_list() do
    GenServer.call(__MODULE__, :db_list)
  end

  def get_free_node() do

  end

  # GenServer callbacks
  @impl true
  def init(_args) do
    {:ok, node_timer} = :timer.apply_interval(5000, GenServer, :cast, [__MODULE__, :update_nodes])

    {:ok,
     %{
       service_nodes: [],
       store_nodes: [],
       node_timer: node_timer
     }}
  end

  @impl true
  def handle_call(
        {:register, node, role},
        _from,
        state
      ) do
    new_state = add_node(state, node, role)
    {:reply, :ok, new_state}
  end

  def handle_call(:db_list, _from, state) do
    {:reply, state.store_nodes ++ state.service_nodes, state}
  end

  @impl true
  def handle_cast(:update_nodes, state) do
    service_nodes =
      for x <- state.service_nodes,
          Enum.find(Node.list(), fn z -> x == z end) != nil,
          do: x

    store_nodes =
      for x <- state.store_nodes,
          Enum.find(Node.list(), fn z -> x == z end) != nil,
          do: x

    new_state = %{state | service_nodes: service_nodes, store_nodes: store_nodes}

    # IO.inspect(new_state, label: "Update nodes.")

    {:noreply, new_state}
  end

  @impl true
  def terminate(_reason, state) do
    {:ok, state}
  end

  # Internal
  defp add_node(state, node, :service) do
    %{state | service_nodes: Map.put(state[:service_nodes], node, [:service, 0])}
  end

  defp add_node(state, node, :store) do
    %{state | store_nodes: Map.put(state[:store_nodes], node, [:service, 0])}
  end

  def disconnect(node) do
    Node.disconnect(node)
  end
end
