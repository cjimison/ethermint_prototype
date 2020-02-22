defmodule Gateway.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  """
  def start(_type, _args) do
    children =
      enableNodeRouter([])
      |> enablePortalRouter()
      |> enableMarketplaceRouter()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gateway.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp enableNodeRouter(children) do
    [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Gateway.Node.Router,
        port: Application.get_env(:gateway, :node_port, 8180)
      )
      | children
    ]
  end

  defp enablePortalRouter(children) do
    [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Gateway.Portal.Router,
        port: Application.get_env(:gateway, :portal_port, 8181)
      )
      | children
    ]
  end

  defp enableMarketplaceRouter(children) do
    [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Gateway.Marketplace.Router,
        port: Application.get_env(:gateway, :marketplace_port, 8182)
      )
      | children
    ]
  end
end
