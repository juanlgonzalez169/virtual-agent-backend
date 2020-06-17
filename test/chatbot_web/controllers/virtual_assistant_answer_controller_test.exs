defmodule ChatbotWeb.VirtualAssistantAnswerControllerTest do
  use ChatbotWeb.ConnCase

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantAnswer

  @create_attrs %{
    answer: "some answer",
    identification: "some identification"
  }
  @update_attrs %{
    answer: "some updated answer",
    identification: "some updated identification"
  }
  @invalid_attrs %{answer: nil, identification: nil}

  def fixture(:virtual_assistant_answer) do
    {:ok, virtual_assistant_answer} = CMS.create_virtual_assistant_answer(@create_attrs)
    virtual_assistant_answer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all virtuals_assistants_answers", %{conn: conn} do
      conn = get(conn, Routes.virtual_assistant_answer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create virtual_assistant_answer" do
    test "renders virtual_assistant_answer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_answer_path(conn, :create), virtual_assistant_answer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.virtual_assistant_answer_path(conn, :show, id))

      assert %{
               "id" => id,
               "answer" => "some answer",
               "identification" => "some identification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_answer_path(conn, :create), virtual_assistant_answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update virtual_assistant_answer" do
    setup [:create_virtual_assistant_answer]

    test "renders virtual_assistant_answer when data is valid", %{conn: conn, virtual_assistant_answer: %VirtualAssistantAnswer{id: id} = virtual_assistant_answer} do
      conn = put(conn, Routes.virtual_assistant_answer_path(conn, :update, virtual_assistant_answer), virtual_assistant_answer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.virtual_assistant_answer_path(conn, :show, id))

      assert %{
               "id" => id,
               "answer" => "some updated answer",
               "identification" => "some updated identification"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, virtual_assistant_answer: virtual_assistant_answer} do
      conn = put(conn, Routes.virtual_assistant_answer_path(conn, :update, virtual_assistant_answer), virtual_assistant_answer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete virtual_assistant_answer" do
    setup [:create_virtual_assistant_answer]

    test "deletes chosen virtual_assistant_answer", %{conn: conn, virtual_assistant_answer: virtual_assistant_answer} do
      conn = delete(conn, Routes.virtual_assistant_answer_path(conn, :delete, virtual_assistant_answer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.virtual_assistant_answer_path(conn, :show, virtual_assistant_answer))
      end
    end
  end

  defp create_virtual_assistant_answer(_) do
    virtual_assistant_answer = fixture(:virtual_assistant_answer)
    {:ok, virtual_assistant_answer: virtual_assistant_answer}
  end
end
