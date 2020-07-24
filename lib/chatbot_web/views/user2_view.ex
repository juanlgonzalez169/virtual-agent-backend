defmodule ChatbotWeb.User2View do
  use ChatbotWeb, :view
  alias ChatbotWeb.User2View

  def render("show.json", %{user: user}) do
    %{data: render_one(user, User2View, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      user_plan: user.user_plan,
      is_active: user.is_active,
      is_admin: user.is_admin,
      avatar: user.avatar,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at}

  end
end
