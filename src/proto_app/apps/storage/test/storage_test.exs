defmodule StorageTest do
  use ExUnit.Case
  doctest Storage

  test "greets the world" do
    assert Storage.hello() == :world
  end

  test "create a user via access_pass" do
    # Create a user
    name = UUID.uuid4()

    {:ok, info} =
      AccessPass.register(%{
        username: name,
        password: "foobar",
        password_confirm: "foobar",
        email: "#{name}@gmail.com",
        meta: %{
          msg: "It's me ... Chris!"
        }
      })

    # Confirm the account
    {:ok, _msg} = AccessPass.confirm(info.access_token)

    # Log the user in
    {:ok, info} = AccessPass.login(name, "foobar")

    IO.puts("Info = #{inspect(info)}")
  end
end
