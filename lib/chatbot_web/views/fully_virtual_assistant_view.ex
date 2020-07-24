defmodule ChatbotWeb.FullyVirtualAssistantView do
  use ChatbotWeb, :view

  alias ChatbotWeb.{FullyVirtualAssistantView}

  def render("fully_index.json", %{fully_virtuals_assistants: fully_virtuals_assistants}) do
    %{data: render_many(fully_virtuals_assistants, FullyVirtualAssistantView, "fully_virtual_assistant.json")}
  end

  def render("fully_show.json", %{fully_virtual_assistant: fully_virtual_assistant}) do
    %{data: render_one(fully_virtual_assistant, FullyVirtualAssistantView, "fully_virtual_assistant.json")}
  end

  def render("fully_virtual_assistant.json", %{fully_virtual_assistant: fully_virtual_assistant}) do
    %{
      id: fully_virtual_assistant.id,
      name: fully_virtual_assistant.name,
      phone: fully_virtual_assistant.phone,
      description: fully_virtual_assistant.description,
      #virtuals_assistants_options: render_many(fully_virtual_assistant.virtuals_assistants_options, ChatbotWeb.FullyVirtualAssistantOptionView, "fully_index.json"),
      virtuals_assistants_options: render_many(fully_virtual_assistant.virtuals_assistants_options, __MODULE__, "virtual_assistant_option.json", as: :virtual_assistant_option),
      user_id: fully_virtual_assistant.user_id,
      inserted_at: fully_virtual_assistant.inserted_at,
      updated_at: fully_virtual_assistant.updated_at
    }
  end

  def render("virtual_assistant_option.json", %{virtual_assistant_option: virtual_assistant_option}) do
    %{
      id: virtual_assistant_option.id,
      identification: virtual_assistant_option.identification,
      option: virtual_assistant_option.option,
      virtuals_assistants_questions: render_many(virtual_assistant_option.virtuals_assistants_questions, __MODULE__, "virtual_assistant_question.json", as: :virtual_assistant_question),
      inserted_at: virtual_assistant_option.inserted_at,
      updated_at: virtual_assistant_option.updated_at
    }
  end

  def render("virtual_assistant_question.json", %{virtual_assistant_question: virtual_assistant_question}) do
    %{
      id: virtual_assistant_question.id,
      identification: virtual_assistant_question.identification,
      question: virtual_assistant_question.question,
      tags: render_many(virtual_assistant_question.virtuals_assistants_tags, __MODULE__, "virtual_assistant_tag.json", as: :virtual_assistant_tag),
      answers: render_many(virtual_assistant_question.virtuals_assistants_answers, __MODULE__, "virtual_assistant_answer.json", as: :virtual_assistant_answer),
      inserted_at: virtual_assistant_question.inserted_at,
      updated_at: virtual_assistant_question.updated_at
    }
  end

  def render("virtual_assistant_answer.json", %{virtual_assistant_answer: virtual_assistant_answer}) do
    %{
      id: virtual_assistant_answer.id,
      identification: virtual_assistant_answer.identification,
      answer: virtual_assistant_answer.answer,
      inserted_at: virtual_assistant_answer.inserted_at,
      updated_at: virtual_assistant_answer.updated_at
    }
  end

  def render("virtual_assistant_tag.json", %{virtual_assistant_tag: virtual_assistant_tag}) do
    %{
      id: virtual_assistant_tag.id,
      identification: virtual_assistant_tag.identification,
      tag: virtual_assistant_tag.tag,
      inserted_at: virtual_assistant_tag.inserted_at,
      updated_at: virtual_assistant_tag.updated_at
    }
  end

end
