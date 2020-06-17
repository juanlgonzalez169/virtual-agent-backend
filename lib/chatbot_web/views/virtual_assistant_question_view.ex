defmodule ChatbotWeb.VirtualAssistantQuestionView do
  use ChatbotWeb, :view
  alias ChatbotWeb.VirtualAssistantQuestionView

  def render("index.json", %{virtuals_assistants_questions: virtuals_assistants_questions}) do
    %{data: render_many(virtuals_assistants_questions, VirtualAssistantQuestionView, "virtual_assistant_question.json")}
  end

  def render("show.json", %{virtual_assistant_question: virtual_assistant_question}) do
    %{data: render_one(virtual_assistant_question, VirtualAssistantQuestionView, "virtual_assistant_question.json")}
  end

  def render("virtual_assistant_question.json", %{virtual_assistant_question: virtual_assistant_question}) do
    %{
      id: virtual_assistant_question.id,
      identification: virtual_assistant_question.identification,
      question: virtual_assistant_question.question,
      virtual_assistant_option_id: virtual_assistant_question.virtual_assistant_option_id
    }
  end
end
