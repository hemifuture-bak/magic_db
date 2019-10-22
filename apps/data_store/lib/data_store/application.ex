defmodule DataStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    join_cluster()

    children = [
      # Starts a worker by calling: DataStore.Worker.start_link(arg)
      # {DataStore.Worker, arg}
      {DataStore.Worker, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp join_cluster() do
    contact_node = Application.get_env(:data_store, :contact_node, [])
    :pong = Node.ping(contact_node)
    DataInit.initialize(contact_node, :store)
    :rpc.call(contact_node, DataContact.ContactManager, :register, [node(), :store])
    # IO.inspect(result)
  end
end
