defmodule ChatbotWeb.VirtualAssistantAnswerView do
  use ChatbotWeb, :view
  alias ChatbotWeb.VirtualAssistantAnswerView

  def render("index.json", %{virtuals_assistants_answers: virtuals_assistants_answers}) do
    %{data: render_many(virtuals_assistants_answers, VirtualAssistantAnswerView, "virtual_assistant_answer.json")}
  end

  def render("show.json", %{virtual_assistant_answer: virtual_assistant_answer}) do
    %{data: render_one(virtual_assistant_answer, VirtualAssistantAnswerView, "virtual_assistant_answer.json")}
  end

  def render("virtual_assistant_answer.json", %{virtual_assistant_answer: virtual_assistant_answer}) do
    %{
      id: virtual_assistant_answer.id,
      identification: virtual_assistant_answer.identification,
      answer: virtual_assistant_answer.answer,
      virtual_assistant_question_id: virtual_assistant_answer.virtual_assistant_question_id,
      inserted_at: virtual_assistant_answer.inserted_at,
      updated_at: virtual_assistant_answer.updated_at
    }
  end
end
