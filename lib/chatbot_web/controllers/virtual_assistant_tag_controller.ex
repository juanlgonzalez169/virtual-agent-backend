defmodule ChatbotWeb.VirtualAssistantTagController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantTag

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    virtuals_assistants_tags = CMS.list_virtuals_assistants_tags()
    render(conn, "index.json", virtuals_assistants_tags: virtuals_assistants_tags)
  end

  def create(conn, %{"virtual_assistant_tag" => virtual_assistant_tag_params}) do
    with {:ok, %VirtualAssistantTag{} = virtual_assistant_tag} <- CMS.create_virtual_assistant_tag(virtual_assistant_tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.virtual_assistant_tag_path(conn, :show, virtual_assistant_tag))
      |> render("show.json", virtual_assistant_tag: virtual_assistant_tag)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_assistant_tag = CMS.get_virtual_assistant_tag!(id)
    render(conn, "show.json", virtual_assistant_tag: virtual_assistant_tag)
  end

  def update(conn, %{"id" => id, "virtual_assistant_tag" => virtual_assistant_tag_params}) do
    virtual_assistant_tag = CMS.get_virtual_assistant_tag!(id)

    with {:ok, %VirtualAssistantTag{} = virtual_assistant_tag} <- CMS.update_virtual_assistant_tag(virtual_assistant_tag, virtual_assistant_tag_params) do
      render(conn, "show.json", virtual_assistant_tag: virtual_assistant_tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_assistant_tag = CMS.get_virtual_assistant_tag!(id)

    with {:ok, %VirtualAssistantTag{}} <- CMS.delete_virtual_assistant_tag(virtual_assistant_tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
