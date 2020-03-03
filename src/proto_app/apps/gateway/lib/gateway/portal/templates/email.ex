defmodule Gateway.Portal.Templates.Email do
  use AccessPassBehavior

  def confirmation_email() do
    tls = Application.get_env(:gateway, :http_base, "http")
    port = Application.get_env(:gateway, :portal_port, 8181)
    server = Application.get_env(:gateway, :dns_name, "localhost")

    """
    <a href="#{tls}://#{server}:#{port}/portal/commands/v1/auth/confirm?confirm_id=<%= conf_key %>">Please confirm you access</a>
    """
  end
end
