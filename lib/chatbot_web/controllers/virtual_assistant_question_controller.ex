defmodule ChatbotWeb.VirtualAssistantQuestionController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantQuestion

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    virtuals_assistants_questions = CMS.list_virtuals_assistants_questions()
    render(conn, "index.json", virtuals_assistants_questions: virtuals_assistants_questions)
  end

  def create(conn, %{"virtual_assistant_question" => virtual_assistant_question_params}) do
    with {:ok, %VirtualAssistantQuestion{} = virtual_assistant_question} <- CMS.create_virtual_assistant_question(virtual_assistant_question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.virtual_assistant_question_path(conn, :show, virtual_assistant_question))
      |> render("show.json", virtual_assistant_question: virtual_assistant_question)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_assistant_question = CMS.get_virtual_assistant_question!(id)
    render(conn, "show.json", virtual_assistant_question: virtual_assistant_question)
  end

  def update(conn, %{"id" => id, "virtual_assistant_question" => virtual_assistant_question_params}) do
    virtual_assistant_question = CMS.get_virtual_assistant_question!(id)

    with {:ok, %VirtualAssistantQuestion{} = virtual_assistant_question} <- CMS.update_virtual_assistant_question(virtual_assistant_question, virtual_assistant_question_params) do
      render(conn, "show.json", virtual_assistant_question: virtual_assistant_question)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_assistant_question = CMS.get_virtual_assistant_question!(id)

    with {:ok, %VirtualAssistantQuestion{}} <- CMS.delete_virtual_assistant_question(virtual_assistant_question) do
      send_resp(conn, :no_content, "")
    end
  end
end
