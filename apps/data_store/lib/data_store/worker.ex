defmodule DataStore.Worker do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [{:name, __MODULE__}])
  end

  @impl true
  def init(_args) do

    {:ok, %{}, 0}
  end

  @impl true
  def handle_info(:timeout, state) do
    {:noreply, state}
  end

  end
