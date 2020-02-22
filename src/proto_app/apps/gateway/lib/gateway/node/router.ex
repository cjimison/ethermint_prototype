defmodule Gateway.Node.Router do
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

  forward("/node/status/v1", to: Gateway.Node.Status.V1.Receiver)

  match _ do
    Logger.error("[Gateway.Base.Router] Unknown Request: #{inspect(conn.body_params)}")
    send_resp(conn, 404, "Invalid Forte Route")
  end
end
