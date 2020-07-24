defmodule ChatbotWeb.UserController do
  use ChatbotWeb, :controller

  alias Chatbot.Users

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"email" => email}) do
    user = Users.get_user!(email)
    render(conn, "show.json", user: user)
  end
end
