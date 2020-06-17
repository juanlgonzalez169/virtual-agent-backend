defmodule ChatbotWeb.VirtualAssistantOptionControllerTest do
  use ChatbotWeb.ConnCase

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantOption

  @create_attrs %{
    identification: "some identification",
    option: "some option"
  }
  @update_attrs %{
    identification: "some updated identification",
    option: "some updated option"
  }
  @invalid_attrs %{identification: nil, option: nil}

  def fixture(:virtual_assistant_option) do
    {:ok, virtual_assistant_option} = CMS.create_virtual_assistant_option(@create_attrs)
    virtual_assistant_option
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all virtuals_assistants_options", %{conn: conn} do
      conn = get(conn, Routes.virtual_assistant_option_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create virtual_assistant_option" do
    test "renders virtual_assistant_option when data is valid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_option_path(conn, :create), virtual_assistant_option: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.virtual_assistant_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some identification",
               "option" => "some option"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_option_path(conn, :create), virtual_assistant_option: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update virtual_assistant_option" do
    setup [:create_virtual_assistant_option]

    test "renders virtual_assistant_option when data is valid", %{conn: conn, virtual_assistant_option: %VirtualAssistantOption{id: id} = virtual_assistant_option} do
      conn = put(conn, Routes.virtual_assistant_option_path(conn, :update, virtual_assistant_option), virtual_assistant_option: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.virtual_assistant_option_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some updated identification",
               "option" => "some updated option"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, virtual_assistant_option: virtual_assistant_option} do
      conn = put(conn, Routes.virtual_assistant_option_path(conn, :update, virtual_assistant_option), virtual_assistant_option: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete virtual_assistant_option" do
    setup [:create_virtual_assistant_option]

    test "deletes chosen virtual_assistant_option", %{conn: conn, virtual_assistant_option: virtual_assistant_option} do
      conn = delete(conn, Routes.virtual_assistant_option_path(conn, :delete, virtual_assistant_option))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.virtual_assistant_option_path(conn, :show, virtual_assistant_option))
      end
    end
  end

  defp create_virtual_assistant_option(_) do
    virtual_assistant_option = fixture(:virtual_assistant_option)
    {:ok, virtual_assistant_option: virtual_assistant_option}
  end
end
