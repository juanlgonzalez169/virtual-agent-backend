defmodule ChatbotWeb.User2Controller do
  use ChatbotWeb, :controller

  alias Chatbot.Users

  action_fallback ChatbotWeb.FallbackController

  def show(conn, %{"email" => email}) do
    user = Users.get_user_by_email(email)
    render(conn, "show.json", user: user)
  end
end
