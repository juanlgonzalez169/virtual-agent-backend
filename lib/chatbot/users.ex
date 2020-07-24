defmodule Chatbot.Users do
  import Ecto.Query, warn: false
  alias Chatbot.Repo

  alias Chatbot.Users.User

  def list_users do
    User
    |> Repo.all()
  end

  def get_user!(email) do
    User
    |> Repo.get_by(email: email)
  end
end
