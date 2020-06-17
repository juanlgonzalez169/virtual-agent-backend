defmodule ChatbotWeb.VirtualAssistantTagView do
  use ChatbotWeb, :view
  alias ChatbotWeb.VirtualAssistantTagView

  def render("index.json", %{virtuals_assistants_tags: virtuals_assistants_tags}) do
    %{data: render_many(virtuals_assistants_tags, VirtualAssistantTagView, "virtual_assistant_tag.json")}
  end

  def render("show.json", %{virtual_assistant_tag: virtual_assistant_tag}) do
    %{data: render_one(virtual_assistant_tag, VirtualAssistantTagView, "virtual_assistant_tag.json")}
  end

  def render("virtual_assistant_tag.json", %{virtual_assistant_tag: virtual_assistant_tag}) do
    %{
      id: virtual_assistant_tag.id,
      identification: virtual_assistant_tag.identification,
      tag: virtual_assistant_tag.tag,
      virtual_assistant_question_id: virtual_assistant_tag.virtual_assistant_question_id
    }
  end
end
