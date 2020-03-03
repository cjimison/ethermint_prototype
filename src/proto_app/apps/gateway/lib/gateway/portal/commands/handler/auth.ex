defmodule Gateway.Portal.Commands.Handler.Auth do
  @moduledoc """
  """
  require Logger

  @spec check(String.t()) :: {:error, <<_::160>>} | {:ok, map}
  def check(accessToken) do
    AccessPass.logged?(accessToken)
  end

  @spec refresh(String.t()) :: {:error, <<_::160>>} | {:ok, map}
  def refresh(refreshToken) do
    AccessPass.refresh(refreshToken)
  end

  @spec register(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          {:error, <<_::200>> | %{optional(atom) => [binary]}} | {:ok, any}
  def register(data) do
    AccessPass.register(data)
  end

  def confirm(confirmId) do
    AccessPass.confirm(confirmId)
  end

  @spec login(String.t(), String.t()) :: {:error, <<_::200, _::_*64>>} | {:ok, map}
  def login(username, password) do
    case AccessPass.login(username, password) do
      {:ok, map} ->
        # TODO:
        # Lets pull out the meta data.  This should really
        # be returned as part of the login.
        {:ok, Map.put(map, "meta", Storage.Auth.User.metaByName(username))}

      e ->
        e
    end
  end

  def logout(accessToken) do
    AccessPass.logout(accessToken)
  end

  def resetPassword(user) do
    AccessPass.reset_password(user)
  end

  def changePassword(id, pass, passConf) do
    AccessPass.change_password(id, pass, passConf)
  end

  def forgotUsername(email) do
    AccessPass.forgot_username(email)
  end
end
