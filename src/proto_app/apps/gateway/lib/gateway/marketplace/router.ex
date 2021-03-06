defmodule Gateway.Marketplace.Router do
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

  forward("/markeplace/v1", to: Gateway.Marketplace.V1.Receiver)

  match _ do
    Logger.error("[Gateway.Markeplace.Router] Unknown Request: #{inspect(conn.body_params)}")
    send_resp(conn, 404, "Invalid Forte Route")
  end
end
