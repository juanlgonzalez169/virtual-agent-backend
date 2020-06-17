defmodule ChatbotWeb.VirtualAssistantAnswerController do
  use ChatbotWeb, :controller

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantAnswer

  action_fallback ChatbotWeb.FallbackController

  def index(conn, _params) do
    virtuals_assistants_answers = CMS.list_virtuals_assistants_answers()
    render(conn, "index.json", virtuals_assistants_answers: virtuals_assistants_answers)
  end

  def create(conn, %{"virtual_assistant_answer" => virtual_assistant_answer_params}) do
    with {:ok, %VirtualAssistantAnswer{} = virtual_assistant_answer} <- CMS.create_virtual_assistant_answer(virtual_assistant_answer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.virtual_assistant_answer_path(conn, :show, virtual_assistant_answer))
      |> render("show.json", virtual_assistant_answer: virtual_assistant_answer)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_assistant_answer = CMS.get_virtual_assistant_answer!(id)
    render(conn, "show.json", virtual_assistant_answer: virtual_assistant_answer)
  end

  def update(conn, %{"id" => id, "virtual_assistant_answer" => virtual_assistant_answer_params}) do
    virtual_assistant_answer = CMS.get_virtual_assistant_answer!(id)

    with {:ok, %VirtualAssistantAnswer{} = virtual_assistant_answer} <- CMS.update_virtual_assistant_answer(virtual_assistant_answer, virtual_assistant_answer_params) do
      render(conn, "show.json", virtual_assistant_answer: virtual_assistant_answer)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_assistant_answer = CMS.get_virtual_assistant_answer!(id)

    with {:ok, %VirtualAssistantAnswer{}} <- CMS.delete_virtual_assistant_answer(virtual_assistant_answer) do
      send_resp(conn, :no_content, "")
    end
  end
end
