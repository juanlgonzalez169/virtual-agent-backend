defmodule ChatbotWeb.VirtualAssistantTagControllerTest do
  use ChatbotWeb.ConnCase

  alias Chatbot.CMS
  alias Chatbot.CMS.VirtualAssistantTag

  @create_attrs %{
    identification: "some identification",
    tag: "some tag"
  }
  @update_attrs %{
    identification: "some updated identification",
    tag: "some updated tag"
  }
  @invalid_attrs %{identification: nil, tag: nil}

  def fixture(:virtual_assistant_tag) do
    {:ok, virtual_assistant_tag} = CMS.create_virtual_assistant_tag(@create_attrs)
    virtual_assistant_tag
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all virtuals_assistants_tags", %{conn: conn} do
      conn = get(conn, Routes.virtual_assistant_tag_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create virtual_assistant_tag" do
    test "renders virtual_assistant_tag when data is valid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_tag_path(conn, :create), virtual_assistant_tag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.virtual_assistant_tag_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some identification",
               "tag" => "some tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.virtual_assistant_tag_path(conn, :create), virtual_assistant_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update virtual_assistant_tag" do
    setup [:create_virtual_assistant_tag]

    test "renders virtual_assistant_tag when data is valid", %{conn: conn, virtual_assistant_tag: %VirtualAssistantTag{id: id} = virtual_assistant_tag} do
      conn = put(conn, Routes.virtual_assistant_tag_path(conn, :update, virtual_assistant_tag), virtual_assistant_tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.virtual_assistant_tag_path(conn, :show, id))

      assert %{
               "id" => id,
               "identification" => "some updated identification",
               "tag" => "some updated tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, virtual_assistant_tag: virtual_assistant_tag} do
      conn = put(conn, Routes.virtual_assistant_tag_path(conn, :update, virtual_assistant_tag), virtual_assistant_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete virtual_assistant_tag" do
    setup [:create_virtual_assistant_tag]

    test "deletes chosen virtual_assistant_tag", %{conn: conn, virtual_assistant_tag: virtual_assistant_tag} do
      conn = delete(conn, Routes.virtual_assistant_tag_path(conn, :delete, virtual_assistant_tag))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.virtual_assistant_tag_path(conn, :show, virtual_assistant_tag))
      end
    end
  end

  defp create_virtual_assistant_tag(_) do
    virtual_assistant_tag = fixture(:virtual_assistant_tag)
    {:ok, virtual_assistant_tag: virtual_assistant_tag}
  end
end
