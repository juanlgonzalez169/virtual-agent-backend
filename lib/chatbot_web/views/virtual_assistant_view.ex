defmodule ChatbotWeb.VirtualAssistantView do
  use ChatbotWeb, :view
  alias ChatbotWeb.VirtualAssistantView

  def render("index.json", %{virtuals_assistants: virtuals_assistants}) do
    %{data: render_many(virtuals_assistants, VirtualAssistantView, "virtual_assistant.json")}
  end

  def render("show.json", %{virtual_assistant: virtual_assistant}) do
    %{data: render_one(virtual_assistant, VirtualAssistantView, "virtual_assistant.json")}
  end

  def render("virtual_assistant.json", %{virtual_assistant: virtual_assistant}) do
    %{
      id: virtual_assistant.id,
      name: virtual_assistant.name,
      phone: virtual_assistant.phone,
      description: virtual_assistant.description,
      user_id: virtual_assistant.user_id
    }
  end
end
