defmodule DataFrontend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: DataFrontend.Worker.start_link(arg)
      # {DataFrontend.Worker, arg}
      {DataFrontend.DbBalancer, []},
      :poolboy.child_spec(:worker, poolboy_spec(), []),
      {DataFrontend.Contact, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataFrontend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp poolboy_spec() do
    [
      name: {:local, :worker},
      worker_module: DataFrontend.Worker,
      size: 5,
      max_overflow: 2
    ]
  end
end
