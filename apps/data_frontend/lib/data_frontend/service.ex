defmodule DataFrontend.Service do
  use GenServer

  # APIs
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def call(method, args) do
    apply(:mnesia, method, args)
  end

  # GenServer callbacks
  def init(_args) do
    {:ok, %{}}
  end
end
