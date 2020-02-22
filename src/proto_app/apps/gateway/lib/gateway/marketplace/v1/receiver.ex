defmodule Gateway.Marketplace.V1.Receiver do
  require Logger
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, Gateway.Marketplace.Handler.ping())
  end

  match _ do
    Logger.error(
      "[Gateway.Marketplace.V1.Receiver] Unknown Request: #{inspect(conn.body_params)}"
    )

    send_resp(conn, 404, "Invalid Forte Route")
  end
end
