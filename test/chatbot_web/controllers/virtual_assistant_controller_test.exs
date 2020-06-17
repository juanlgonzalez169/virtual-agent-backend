defmodule ChatbotWeb.VirtualAssistantControllerTest do
  use ChatbotWeb.ConnCase

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistant

  @create_attrs %{
    description: "some description",
    name: "some name",
    phone: "some phone"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    phone: "some updated phone"
  }
  @invalid_attrs %{description: nil, name: nil, phone: nil}

  def fixture(:virtual_assistant) do
    {:ok, virtual_assistant} = CMS.create_virtual_assistant(@create_attrs)
    virtual_assistant
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all virtuals_assistants", %{conn: conn} do
      conn = get(conn, Routes.virtual_assistant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create virtual_assistant" do
    test "renders virtual_assistant when data is valid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_path(conn, :create), virtual_assistant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.virtual_assistant_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_path(conn, :create), virtual_assistant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update virtual_assistant" do
    setup [:create_virtual_assistant]

    test "renders virtual_assistant when data is valid", %{conn: conn, virtual_assistant: %VirtualAssistant{id: id} = virtual_assistant} do
      conn = put(conn, Routes.virtual_assistant_path(conn, :update, virtual_assistant), virtual_assistant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.virtual_assistant_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, virtual_assistant: virtual_assistant} do
      conn = put(conn, Routes.virtual_assistant_path(conn, :update, virtual_assistant), virtual_assistant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete virtual_assistant" do
    setup [:create_virtual_assistant]

    test "deletes chosen virtual_assistant", %{conn: conn, virtual_assistant: virtual_assistant} do
      conn = delete(conn, Routes.virtual_assistant_path(conn, :delete, virtual_assistant))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.virtual_assistant_path(conn, :show, virtual_assistant))
      end
    end
  end

  defp create_virtual_assistant(_) do
    virtual_assistant = fixture(:virtual_assistant)
    {:ok, virtual_assistant: virtual_assistant}
  end
end
