defmodule Storage.Schmea.AddUsers do
  @moduledoc ~S"""
  """
  require Logger
  use Ecto.Schema

  # Define the Ecto schema file of what will be stored in each record
  @primary_key false
  schema "users" do
    field(:user_id, :string, primary_key: true)
    field(:username, :string)
    field(:meta, :map)
    field(:email, :string)
    field(:password_hash, :string)
    field(:successful_login_attemps, :integer)
    field(:confirm_id, :string)
    field(:password_reset_key, :string)
    field(:confirmed, :boolean)
  end

  # of schema definition
end
