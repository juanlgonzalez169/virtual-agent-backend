defmodule Chatbot.Users do
  import Ecto.Query, warn: false
  alias Chatbot.Repo

  alias Chatbot.Users.User

  def list_users do
    User
    |> Repo.all()
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
  end
end
