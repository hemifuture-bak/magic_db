defmodule DataService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    link()

    children = [
      # Starts a worker by calling: DataService.Worker.start_link(arg)
      # {DataService.Worker, arg}
      {DataService.UidGenerator, []},
      {DataService.InterfaceSup, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp link() do
    contact_node = Application.get_env(:data_service, :contact_node, [])
    :pong = Node.ping(contact_node)
    DataInit.initialize(contact_node, :service)
    result = :rpc.call(contact_node, DataContact.ContactManager, :register, [node(), :service])
    IO.inspect(result)
  end
end
