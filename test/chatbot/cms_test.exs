defmodule Chatbot.CMSTest do
  use Chatbot.DataCase

  alias Chatbot.CMS

  describe "virtuals_assistants" do
    alias Chatbot.CMS.VirtualAssistant

    @valid_attrs %{description: "some description", name: "some name", phone: "some phone"}
    @update_attrs %{description: "some updated description", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{description: nil, name: nil, phone: nil}

    def virtual_assistant_fixture(attrs \\ %{}) do
      {:ok, virtual_assistant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_virtual_assistant()

      virtual_assistant
    end

    test "list_virtuals_assistants/0 returns all virtuals_assistants" do
      virtual_assistant = virtual_assistant_fixture()
      assert CMS.list_virtuals_assistants() == [virtual_assistant]
    end

    test "get_virtual_assistant!/1 returns the virtual_assistant with given id" do
      virtual_assistant = virtual_assistant_fixture()
      assert CMS.get_virtual_assistant!(virtual_assistant.id) == virtual_assistant
    end

    test "create_virtual_assistant/1 with valid data creates a virtual_assistant" do
      assert {:ok, %VirtualAssistant{} = virtual_assistant} = CMS.create_virtual_assistant(@valid_attrs)
      assert virtual_assistant.description == "some description"
      assert virtual_assistant.name == "some name"
      assert virtual_assistant.phone == "some phone"
    end

    test "create_virtual_assistant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_virtual_assistant(@invalid_attrs)
    end

    test "update_virtual_assistant/2 with valid data updates the virtual_assistant" do
      virtual_assistant = virtual_assistant_fixture()
      assert {:ok, %VirtualAssistant{} = virtual_assistant} = CMS.update_virtual_assistant(virtual_assistant, @update_attrs)
      assert virtual_assistant.description == "some updated description"
      assert virtual_assistant.name == "some updated name"
      assert virtual_assistant.phone == "some updated phone"
    end

    test "update_virtual_assistant/2 with invalid data returns error changeset" do
      virtual_assistant = virtual_assistant_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_virtual_assistant(virtual_assistant, @invalid_attrs)
      assert virtual_assistant == CMS.get_virtual_assistant!(virtual_assistant.id)
    end

    test "delete_virtual_assistant/1 deletes the virtual_assistant" do
      virtual_assistant = virtual_assistant_fixture()
      assert {:ok, %VirtualAssistant{}} = CMS.delete_virtual_assistant(virtual_assistant)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_virtual_assistant!(virtual_assistant.id) end
    end

    test "change_virtual_assistant/1 returns a virtual_assistant changeset" do
      virtual_assistant = virtual_assistant_fixture()
      assert %Ecto.Changeset{} = CMS.change_virtual_assistant(virtual_assistant)
    end
  end

  describe "virtuals_assistants_options" do
    alias Chatbot.CMS.VirtualAssistantOption

    @valid_attrs %{identification: "some identification", option: "some option"}
    @update_attrs %{identification: "some updated identification", option: "some updated option"}
    @invalid_attrs %{identification: nil, option: nil}

    def virtual_assistant_option_fixture(attrs \\ %{}) do
      {:ok, virtual_assistant_option} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_virtual_assistant_option()

      virtual_assistant_option
    end

    test "list_virtuals_assistants_options/0 returns all virtuals_assistants_options" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert CMS.list_virtuals_assistants_options() == [virtual_assistant_option]
    end

    test "get_virtual_assistant_option!/1 returns the virtual_assistant_option with given id" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert CMS.get_virtual_assistant_option!(virtual_assistant_option.id) == virtual_assistant_option
    end

    test "create_virtual_assistant_option/1 with valid data creates a virtual_assistant_option" do
      assert {:ok, %VirtualAssistantOption{} = virtual_assistant_option} = CMS.create_virtual_assistant_option(@valid_attrs)
      assert virtual_assistant_option.identification == "some identification"
      assert virtual_assistant_option.option == "some option"
    end

    test "create_virtual_assistant_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_virtual_assistant_option(@invalid_attrs)
    end

    test "update_virtual_assistant_option/2 with valid data updates the virtual_assistant_option" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert {:ok, %VirtualAssistantOption{} = virtual_assistant_option} = CMS.update_virtual_assistant_option(virtual_assistant_option, @update_attrs)
      assert virtual_assistant_option.identification == "some updated identification"
      assert virtual_assistant_option.option == "some updated option"
    end

    test "update_virtual_assistant_option/2 with invalid data returns error changeset" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_virtual_assistant_option(virtual_assistant_option, @invalid_attrs)
      assert virtual_assistant_option == CMS.get_virtual_assistant_option!(virtual_assistant_option.id)
    end

    test "delete_virtual_assistant_option/1 deletes the virtual_assistant_option" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert {:ok, %VirtualAssistantOption{}} = CMS.delete_virtual_assistant_option(virtual_assistant_option)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_virtual_assistant_option!(virtual_assistant_option.id) end
    end

    test "change_virtual_assistant_option/1 returns a virtual_assistant_option changeset" do
      virtual_assistant_option = virtual_assistant_option_fixture()
      assert %Ecto.Changeset{} = CMS.change_virtual_assistant_option(virtual_assistant_option)
    end
  end

  describe "virtuals_assistants_questions" do
    alias Chatbot.CMS.VirtualAssistantQuestion

    @valid_attrs %{identification: "some identification", question: "some question"}
    @update_attrs %{identification: "some updated identification", question: "some updated question"}
    @invalid_attrs %{identification: nil, question: nil}

    def virtual_assistant_question_fixture(attrs \\ %{}) do
      {:ok, virtual_assistant_question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_virtual_assistant_question()

      virtual_assistant_question
    end

    test "list_virtuals_assistants_questions/0 returns all virtuals_assistants_questions" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert CMS.list_virtuals_assistants_questions() == [virtual_assistant_question]
    end

    test "get_virtual_assistant_question!/1 returns the virtual_assistant_question with given id" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert CMS.get_virtual_assistant_question!(virtual_assistant_question.id) == virtual_assistant_question
    end

    test "create_virtual_assistant_question/1 with valid data creates a virtual_assistant_question" do
      assert {:ok, %VirtualAssistantQuestion{} = virtual_assistant_question} = CMS.create_virtual_assistant_question(@valid_attrs)
      assert virtual_assistant_question.identification == "some identification"
      assert virtual_assistant_question.question == "some question"
    end

    test "create_virtual_assistant_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_virtual_assistant_question(@invalid_attrs)
    end

    test "update_virtual_assistant_question/2 with valid data updates the virtual_assistant_question" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert {:ok, %VirtualAssistantQuestion{} = virtual_assistant_question} = CMS.update_virtual_assistant_question(virtual_assistant_question, @update_attrs)
      assert virtual_assistant_question.identification == "some updated identification"
      assert virtual_assistant_question.question == "some updated question"
    end

    test "update_virtual_assistant_question/2 with invalid data returns error changeset" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_virtual_assistant_question(virtual_assistant_question, @invalid_attrs)
      assert virtual_assistant_question == CMS.get_virtual_assistant_question!(virtual_assistant_question.id)
    end

    test "delete_virtual_assistant_question/1 deletes the virtual_assistant_question" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert {:ok, %VirtualAssistantQuestion{}} = CMS.delete_virtual_assistant_question(virtual_assistant_question)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_virtual_assistant_question!(virtual_assistant_question.id) end
    end

    test "change_virtual_assistant_question/1 returns a virtual_assistant_question changeset" do
      virtual_assistant_question = virtual_assistant_question_fixture()
      assert %Ecto.Changeset{} = CMS.change_virtual_assistant_question(virtual_assistant_question)
    end
  end

  describe "virtuals_assistants_answers" do
    alias Chatbot.CMS.VirtualAssistantAnswer

    @valid_attrs %{answer: "some answer", identification: "some identification"}
    @update_attrs %{answer: "some updated answer", identification: "some updated identification"}
    @invalid_attrs %{answer: nil, identification: nil}

    def virtual_assistant_answer_fixture(attrs \\ %{}) do
      {:ok, virtual_assistant_answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_virtual_assistant_answer()

      virtual_assistant_answer
    end

    test "list_virtuals_assistants_answers/0 returns all virtuals_assistants_answers" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert CMS.list_virtuals_assistants_answers() == [virtual_assistant_answer]
    end

    test "get_virtual_assistant_answer!/1 returns the virtual_assistant_answer with given id" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert CMS.get_virtual_assistant_answer!(virtual_assistant_answer.id) == virtual_assistant_answer
    end

    test "create_virtual_assistant_answer/1 with valid data creates a virtual_assistant_answer" do
      assert {:ok, %VirtualAssistantAnswer{} = virtual_assistant_answer} = CMS.create_virtual_assistant_answer(@valid_attrs)
      assert virtual_assistant_answer.answer == "some answer"
      assert virtual_assistant_answer.identification == "some identification"
    end

    test "create_virtual_assistant_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_virtual_assistant_answer(@invalid_attrs)
    end

    test "update_virtual_assistant_answer/2 with valid data updates the virtual_assistant_answer" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert {:ok, %VirtualAssistantAnswer{} = virtual_assistant_answer} = CMS.update_virtual_assistant_answer(virtual_assistant_answer, @update_attrs)
      assert virtual_assistant_answer.answer == "some updated answer"
      assert virtual_assistant_answer.identification == "some updated identification"
    end

    test "update_virtual_assistant_answer/2 with invalid data returns error changeset" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_virtual_assistant_answer(virtual_assistant_answer, @invalid_attrs)
      assert virtual_assistant_answer == CMS.get_virtual_assistant_answer!(virtual_assistant_answer.id)
    end

    test "delete_virtual_assistant_answer/1 deletes the virtual_assistant_answer" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert {:ok, %VirtualAssistantAnswer{}} = CMS.delete_virtual_assistant_answer(virtual_assistant_answer)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_virtual_assistant_answer!(virtual_assistant_answer.id) end
    end

    test "change_virtual_assistant_answer/1 returns a virtual_assistant_answer changeset" do
      virtual_assistant_answer = virtual_assistant_answer_fixture()
      assert %Ecto.Changeset{} = CMS.change_virtual_assistant_answer(virtual_assistant_answer)
    end
  end

  describe "virtuals_assistants_tags" do
    alias Chatbot.CMS.VirtualAssistantTag

    @valid_attrs %{identification: "some identification", tag: "some tag"}
    @update_attrs %{identification: "some updated identification", tag: "some updated tag"}
    @invalid_attrs %{identification: nil, tag: nil}

    def virtual_assistant_tag_fixture(attrs \\ %{}) do
      {:ok, virtual_assistant_tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_virtual_assistant_tag()

      virtual_assistant_tag
    end

    test "list_virtuals_assistants_tags/0 returns all virtuals_assistants_tags" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert CMS.list_virtuals_assistants_tags() == [virtual_assistant_tag]
    end

    test "get_virtual_assistant_tag!/1 returns the virtual_assistant_tag with given id" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert CMS.get_virtual_assistant_tag!(virtual_assistant_tag.id) == virtual_assistant_tag
    end

    test "create_virtual_assistant_tag/1 with valid data creates a virtual_assistant_tag" do
      assert {:ok, %VirtualAssistantTag{} = virtual_assistant_tag} = CMS.create_virtual_assistant_tag(@valid_attrs)
      assert virtual_assistant_tag.identification == "some identification"
      assert virtual_assistant_tag.tag == "some tag"
    end

    test "create_virtual_assistant_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_virtual_assistant_tag(@invalid_attrs)
    end

    test "update_virtual_assistant_tag/2 with valid data updates the virtual_assistant_tag" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert {:ok, %VirtualAssistantTag{} = virtual_assistant_tag} = CMS.update_virtual_assistant_tag(virtual_assistant_tag, @update_attrs)
      assert virtual_assistant_tag.identification == "some updated identification"
      assert virtual_assistant_tag.tag == "some updated tag"
    end

    test "update_virtual_assistant_tag/2 with invalid data returns error changeset" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_virtual_assistant_tag(virtual_assistant_tag, @invalid_attrs)
      assert virtual_assistant_tag == CMS.get_virtual_assistant_tag!(virtual_assistant_tag.id)
    end

    test "delete_virtual_assistant_tag/1 deletes the virtual_assistant_tag" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert {:ok, %VirtualAssistantTag{}} = CMS.delete_virtual_assistant_tag(virtual_assistant_tag)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_virtual_assistant_tag!(virtual_assistant_tag.id) end
    end

    test "change_virtual_assistant_tag/1 returns a virtual_assistant_tag changeset" do
      virtual_assistant_tag = virtual_assistant_tag_fixture()
      assert %Ecto.Changeset{} = CMS.change_virtual_assistant_tag(virtual_assistant_tag)
    end
  end
end
