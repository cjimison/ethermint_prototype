defmodule Gateway.Portal.Commands.V1.Receiver.Auth do
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

  # ----------------------------------------------------------------------------
  # Basic Health APIs
  # ----------------------------------------------------------------------------
  post "/validate" do
    send_resp(conn, 404, "Invalid Forte Route")
  end

  post "/login" do
    send_resp(conn, 404, "Invalid Forte Route")
  end

  post "/create" do
    send_resp(conn, 404, "Invalid Forte Route")
  end

  post "/profile" do
    send_resp(conn, 404, "Invalid Forte Route")
  end

  match _ do
    Logger.error("[Gateway.Portal.V1.AuthReceiver] Unknown Request: #{inspect(conn.body_params)}")
    send_resp(conn, 404, "Invalid Forte Route")
  end
end
