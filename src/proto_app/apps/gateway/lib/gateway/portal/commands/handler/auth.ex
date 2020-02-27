defmodule Gateway.Portal.Commands.Handler.Auth do
  @moduledoc """
  """

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

  @spec login(String.t(), String.t()) :: {:error, <<_::200, _::_*64>>} | {:ok, map}
  def login(username, password) do
    AccessPass.login(username, password)
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
