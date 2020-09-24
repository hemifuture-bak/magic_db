defmodule DataPersistance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: DataPersistance.Worker.start_link(arg)
      # {DataPersistance.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataPersistance.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
