defmodule ChatbotWeb.VirtualAssistantOptionController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantOption

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    virtuals_assistants_options = CMS.list_virtuals_assistants_options()
    render(conn, "index.json", virtuals_assistants_options: virtuals_assistants_options)
  end

  def create(conn, %{"virtual_assistant_option" => virtual_assistant_option_params}) do
    with {:ok, %VirtualAssistantOption{} = virtual_assistant_option} <- CMS.create_virtual_assistant_option(virtual_assistant_option_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.virtual_assistant_option_path(conn, :show, virtual_assistant_option))
      |> render("show.json", virtual_assistant_option: virtual_assistant_option)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_assistant_option = CMS.get_virtual_assistant_option!(id)
    render(conn, "show.json", virtual_assistant_option: virtual_assistant_option)
  end

  def update(conn, %{"id" => id, "virtual_assistant_option" => virtual_assistant_option_params}) do
    virtual_assistant_option = CMS.get_virtual_assistant_option!(id)

    with {:ok, %VirtualAssistantOption{} = virtual_assistant_option} <- CMS.update_virtual_assistant_option(virtual_assistant_option, virtual_assistant_option_params) do
      render(conn, "show.json", virtual_assistant_option: virtual_assistant_option)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_assistant_option = CMS.get_virtual_assistant_option!(id)

    with {:ok, %VirtualAssistantOption{}} <- CMS.delete_virtual_assistant_option(virtual_assistant_option) do
      send_resp(conn, :no_content, "")
    end
  end
end
