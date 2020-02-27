defmodule Gateway.Portal.Commands.V1.Receiver.Root do
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
    send_resp(conn, 200, Gateway.Portal.Handler.Root.ping())
  end

  get "/stats" do
    send_resp(conn, 200, Gateway.Portal.Handler.Root.ping())
  end

  match _ do
    Logger.error("[Gateway.Portal.V1.BaseReceiver] Unknown Request: #{inspect(conn.body_params)}")
    send_resp(conn, 404, "Invalid Forte Route")
  end
end
