defmodule ChatbotWeb.VirtualAssistantOptionView do
  use ChatbotWeb, :view
  alias ChatbotWeb.VirtualAssistantOptionView

  def render("index.json", %{virtuals_assistants_options: virtuals_assistants_options}) do
    %{data: render_many(virtuals_assistants_options, VirtualAssistantOptionView, "virtual_assistant_option.json")}
  end

  def render("show.json", %{virtual_assistant_option: virtual_assistant_option}) do
    %{data: render_one(virtual_assistant_option, VirtualAssistantOptionView, "virtual_assistant_option.json")}
  end

  def render("virtual_assistant_option.json", %{virtual_assistant_option: virtual_assistant_option}) do
    %{
      id: virtual_assistant_option.id,
      identification: virtual_assistant_option.identification,
      option: virtual_assistant_option.option,
      virtual_assistant_id: virtual_assistant_option.virtual_assistant_id
    }
  end
end
