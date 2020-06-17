defmodule ChatbotWeb.VirtualAssistantController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistant

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    virtuals_assistants = CMS.list_virtuals_assistants()
    render(conn, "index.json", virtuals_assistants: virtuals_assistants)
  end

  def create(conn, %{"virtual_assistant" => virtual_assistant_params}) do
    with {:ok, %VirtualAssistant{} = virtual_assistant} <- CMS.create_virtual_assistant(virtual_assistant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.virtual_assistant_path(conn, :show, virtual_assistant))
      |> render("show.json", virtual_assistant: virtual_assistant)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_assistant = CMS.get_virtual_assistant!(id)
    render(conn, "show.json", virtual_assistant: virtual_assistant)
  end

  def update(conn, %{"id" => id, "virtual_assistant" => virtual_assistant_params}) do
    virtual_assistant = CMS.get_virtual_assistant!(id)

    with {:ok, %VirtualAssistant{} = virtual_assistant} <- CMS.update_virtual_assistant(virtual_assistant, virtual_assistant_params) do
      render(conn, "show.json", virtual_assistant: virtual_assistant)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_assistant = CMS.get_virtual_assistant!(id)

    with {:ok, %VirtualAssistant{}} <- CMS.delete_virtual_assistant(virtual_assistant) do
      send_resp(conn, :no_content, "")
    end
  end
end
