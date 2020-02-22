defmodule Gateway.Node.Status.Handler do
  require Logger

  @spec ping :: <<_::32>>
  def ping() do
    "pong"
  end
end
