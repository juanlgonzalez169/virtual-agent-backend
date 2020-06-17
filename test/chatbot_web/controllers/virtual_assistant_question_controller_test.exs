defmodule ChatbotWeb.VirtualAssistantQuestionControllerTest do
  use ChatbotWeb.ConnCase

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantQuestion

  @create_attrs %{
    identification: "some identification",
    question: "some question"
  }
  @update_attrs %{
    identification: "some updated identification",
    question: "some updated question"
  }
  @invalid_attrs %{identification: nil, question: nil}

  def fixture(:virtual_assistant_question) do
    {:ok, virtual_assistant_question} = CMS.create_virtual_assistant_question(@create_attrs)
    virtual_assistant_question
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all virtuals_assistants_questions", %{conn: conn} do
      conn = get(conn, Routes.virtual_assistant_question_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create virtual_assistant_question" do
    test "renders virtual_assistant_question when data is valid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_question_path(conn, :create), virtual_assistant_question: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.virtual_assistant_question_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some identification",
               "question" => "some question"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_question_path(conn, :create), virtual_assistant_question: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update virtual_assistant_question" do
    setup [:create_virtual_assistant_question]

    test "renders virtual_assistant_question when data is valid", %{conn: conn, virtual_assistant_question: %VirtualAssistantQuestion{id: id} = virtual_assistant_question} do
      conn = put(conn, Routes.virtual_assistant_question_path(conn, :update, virtual_assistant_question), virtual_assistant_question: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.virtual_assistant_question_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some updated identification",
               "question" => "some updated question"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, virtual_assistant_question: virtual_assistant_question} do
      conn = put(conn, Routes.virtual_assistant_question_path(conn, :update, virtual_assistant_question), virtual_assistant_question: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete virtual_assistant_question" do
    setup [:create_virtual_assistant_question]

    test "deletes chosen virtual_assistant_question", %{conn: conn, virtual_assistant_question: virtual_assistant_question} do
      conn = delete(conn, Routes.virtual_assistant_question_path(conn, :delete, virtual_assistant_question))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.virtual_assistant_question_path(conn, :show, virtual_assistant_question))
      end
    end
  end

  defp create_virtual_assistant_question(_) do
    virtual_assistant_question = fixture(:virtual_assistant_question)
    {:ok, virtual_assistant_question: virtual_assistant_question}
  end
end
