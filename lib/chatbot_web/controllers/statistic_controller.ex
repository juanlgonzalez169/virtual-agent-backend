defmodule ChatbotWeb.StatisticController do
  use ChatbotWeb, :controller

  alias Chatbot.Others
  alias Chatbot.Others.Statistic

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    statistics = Others.list_statistics()
    render(conn, "index.json", statistics: statistics)
  end

  def create(conn, %{"statistic" => statistic_params}) do
    with {:ok, %Statistic{} = statistic} <- Others.create_statistic(statistic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.statistic_path(conn, :show, statistic))
      |> render("show.json", statistic: statistic)
    end
  end

  def show(conn, %{"id" => id}) do
    statistic = Others.get_statistic!(id)
    render(conn, "show.json", statistic: statistic)
  end

  def update(conn, %{"id" => id, "statistic" => statistic_params}) do
    statistic = Others.get_statistic!(id)

    with {:ok, %Statistic{} = statistic} <- Others.update_statistic(statistic, statistic_params) do
      render(conn, "show.json", statistic: statistic)
    end
  end

  def delete(conn, %{"id" => id}) do
    statistic = Others.get_statistic!(id)

    with {:ok, %Statistic{}} <- Others.delete_statistic(statistic) do
      send_resp(conn, :no_content, "")
    end
  end
end
