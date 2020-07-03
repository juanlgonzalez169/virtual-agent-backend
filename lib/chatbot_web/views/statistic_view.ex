defmodule ChatbotWeb.StatisticView do
  use ChatbotWeb, :view
  alias ChatbotWeb.StatisticView

  def render("index.json", %{statistics: statistics}) do
    %{data: render_many(statistics, StatisticView, "statistic.json")}
  end

  def render("show.json", %{statistic: statistic}) do
    %{data: render_one(statistic, StatisticView, "statistic.json")}
  end

  def render("statistic.json", %{statistic: statistic}) do
    %{id: statistic.id,
      received_messages: statistic.received_messages,
      valid_messages: statistic.valid_messages,
      invalid_messages: statistic.invalid_messages,
      accepted_messages: statistic.accepted_messages,
      inserted_at: statistic.inserted_at,
      updated_at: statistic.updated_at}
  end
end
