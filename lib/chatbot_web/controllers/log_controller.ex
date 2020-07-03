defmodule ChatbotWeb.LogController do
  use ChatbotWeb, :controller

  alias Chatbot.Others
  alias Chatbot.Others.Log

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    logs = Others.list_logs()
    render(conn, "index.json", logs: logs)
  end

  def create(conn, %{"log" => log_params}) do
    with {:ok, %Log{} = log} <- Others.create_log(log_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.log_path(conn, :show, log))
      |> render("show.json", log: log)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Others.get_log!(id)
    render(conn, "show.json", log: log)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Others.get_log!(id)

    with {:ok, %Log{} = log} <- Others.update_log(log, log_params) do
      render(conn, "show.json", log: log)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Others.get_log!(id)

    with {:ok, %Log{}} <- Others.delete_log(log) do
      send_resp(conn, :no_content, "")
    end
  end
end
