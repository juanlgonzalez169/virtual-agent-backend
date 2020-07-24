defmodule ChatbotWeb.FullyVirtualAssistantController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    fully_virtuals_assistants = CMS.list_fully_virtuals_assistants()
    render(conn, "fully_index.json", fully_virtuals_assistants: fully_virtuals_assistants)
  end

  def show(conn, %{"id" => id}) do
    fully_virtual_assistant = CMS.get_fully_virtual_assistant!(id)
    render(conn, "fully_show.json", fully_virtual_assistant: fully_virtual_assistant)
  end
end
