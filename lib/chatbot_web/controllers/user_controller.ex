defmodule ChatbotWeb.UserController do
  use ChatbotWeb, :controller

  alias Chatbot.Users

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def filter_by_email(conn, %{"email" => email}) do
    user = Users.get_user_by_email(email)
    render(conn, "show.json", user: user)
  end

end
