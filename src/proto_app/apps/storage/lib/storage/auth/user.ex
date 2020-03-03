defmodule Storage.Auth.User do
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
    field(:successful_login_attempts, :integer)
    field(:confirm_id, :string)
    field(:password_reset_key, :string)
    field(:password_reset_expire, :integer)
    field(:confirmed, :boolean)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end

  @type t :: %Storage.Auth.User{
          confirm_id: String.t(),
          confirmed: boolean,
          email: String.t(),
          inserted_at: NativeDateTime.t(),
          meta: map,
          password_hash: String.t(),
          password_reset_expire: nil | integer(),
          password_reset_key: nil | integer(),
          successful_login_attempts: integer(),
          updated_at: NativeDateTime.t(),
          user_id: String.t(),
          username: String.t()
        }

  @spec all :: [Storage.Auth.User.t()]
  def all() do
    Storage.Repo.all(Storage.Auth.User)
  end

  @spec byName(String.t()) :: nil | Storage.Auth.User.t()
  def byName(name) do
    Storage.Repo.get_by(Storage.Auth.User, username: name)
  end

  @spec byEmail(String.t()) :: nil | Storage.Auth.User.t()
  def byEmail(email) do
    Storage.Repo.get_by(Storage.Auth.User, email: email)
  end

  @spec byId(String.t()) :: nil | Storage.Auth.User.t()
  def byId(id) do
    Storage.Repo.get_by(Storage.Auth.User, user_id: id)
  end

  @doc """
  Read the Meta data field from the users database who matches the given username

  Note: You should use this API if you are sure the user exists.  Otherwise
        you will just get back an empty map and not know if the map was empty
        due to the player not existing OR if the user just has an empty map

  # Arguments:

  name = The string username of record to pull meta

  # Returns

  %{} map of the meta field


  TODO:
  This is currently pulling the full record when really I just
  want the meta field.  Need to profile and see if it is actually
  more performant to eat the network bandwidth and serialization
  time verses say just asking for the single field
  """
  @spec metaByName(String.t()) :: %{}
  def metaByName(name) do
    Storage.Repo.get_by(Storage.Auth.User, username: name)
    |> getMeta()
  end

  @doc """
  Read the Meta data field from the users database who matches the given email

  Note: You should use this API if you are sure the user exists.  Otherwise
        you will just get back an empty map and not know if the map was empty
        due to the player not existing OR if the user just has an empty map

  # Arguments:

  name = The string email of record to pull meta

  # Returns

  %{} map of the meta field.  Empty map if not found

  TODO:
  This is currently pulling the full record when really I just
  want the meta field.  Need to profile and see if it is actually
  more performant to eat the network bandwidth and serialization
  time verses say just asking for the single field
  """
  @spec metaByEmail(String.t()) :: %{}
  def metaByEmail(email) do
    Storage.Repo.get_by(Storage.Auth.User, email: email)
    |> getMeta()
  end

  @doc """
  Read the Meta data field from the users database who matches the given user ID

  # Arguments:

  id = The string id of record to pull meta

  Note: You should use this API if you are sure the user exists.  Otherwise
        you will just get back an empty map and not know if the map was empty
        due to the player not existing OR if the user just has an empty map

  # Returns

  %{} map of the meta field

  TODO:
  This is currently pulling the full record when really I just
  want the meta field.  Need to profile and see if it is actually
  more performant to eat the network bandwidth and serialization
  time verses say just asking for the single field
  """
  @spec metaById(String.t()) :: Storage.Auth.User.t()
  def metaById(id) do
    Storage.Repo.get_by(Storage.Auth.User, user_id: id)
    |> getMeta()
  end

  defp getMeta(nil), do: %{}
  defp getMeta(map), do: Map.get(map, "meta", %{})
end
