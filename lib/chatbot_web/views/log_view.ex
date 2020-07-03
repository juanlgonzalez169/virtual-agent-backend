defmodule ChatbotWeb.LogView do
  use ChatbotWeb, :view
  alias ChatbotWeb.LogView

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{id: log.id,
      tier: log.tier,
      selected_option: log.selected_option,
      inserted_at: log.inserted_at,
      updated_at: log.updated_at}
  end
end
