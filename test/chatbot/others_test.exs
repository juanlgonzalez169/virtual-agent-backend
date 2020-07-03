defmodule Chatbot.OthersTest do
  use Chatbot.DataCase

  alias Chatbot.Others

  describe "statistics" do
    alias Chatbot.Others.Statistic

    @valid_attrs %{accepted_messages: 42, invalid_messages: 42, sendded_messages: 42, valid_messages: 42}
    @update_attrs %{accepted_messages: 43, invalid_messages: 43, sendded_messages: 43, valid_messages: 43}
    @invalid_attrs %{accepted_messages: nil, invalid_messages: nil, sendded_messages: nil, valid_messages: nil}

    def statistic_fixture(attrs \\ %{}) do
      {:ok, statistic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Others.create_statistic()

      statistic
    end

    test "list_statistics/0 returns all statistics" do
      statistic = statistic_fixture()
      assert Others.list_statistics() == [statistic]
    end

    test "get_statistic!/1 returns the statistic with given id" do
      statistic = statistic_fixture()
      assert Others.get_statistic!(statistic.id) == statistic
    end

    test "create_statistic/1 with valid data creates a statistic" do
      assert {:ok, %Statistic{} = statistic} = Others.create_statistic(@valid_attrs)
      assert statistic.accepted_messages == 42
      assert statistic.invalid_messages == 42
      assert statistic.sendded_messages == 42
      assert statistic.valid_messages == 42
    end

    test "create_statistic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Others.create_statistic(@invalid_attrs)
    end

    test "update_statistic/2 with valid data updates the statistic" do
      statistic = statistic_fixture()
      assert {:ok, %Statistic{} = statistic} = Others.update_statistic(statistic, @update_attrs)
      assert statistic.accepted_messages == 43
      assert statistic.invalid_messages == 43
      assert statistic.sendded_messages == 43
      assert statistic.valid_messages == 43
    end

    test "update_statistic/2 with invalid data returns error changeset" do
      statistic = statistic_fixture()
      assert {:error, %Ecto.Changeset{}} = Others.update_statistic(statistic, @invalid_attrs)
      assert statistic == Others.get_statistic!(statistic.id)
    end

    test "delete_statistic/1 deletes the statistic" do
      statistic = statistic_fixture()
      assert {:ok, %Statistic{}} = Others.delete_statistic(statistic)
      assert_raise Ecto.NoResultsError, fn -> Others.get_statistic!(statistic.id) end
    end

    test "change_statistic/1 returns a statistic changeset" do
      statistic = statistic_fixture()
      assert %Ecto.Changeset{} = Others.change_statistic(statistic)
    end
  end

  describe "logs" do
    alias Chatbot.Others.Log

    @valid_attrs %{finalised_chats: 42, selected_option: 42, selected_question: 42, tier: 42, unfinalised_chats: 42}
    @update_attrs %{finalised_chats: 43, selected_option: 43, selected_question: 43, tier: 43, unfinalised_chats: 43}
    @invalid_attrs %{finalised_chats: nil, selected_option: nil, selected_question: nil, tier: nil, unfinalised_chats: nil}

    def log_fixture(attrs \\ %{}) do
      {:ok, log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Others.create_log()

      log
    end

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert Others.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert Others.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      assert {:ok, %Log{} = log} = Others.create_log(@valid_attrs)
      assert log.finalised_chats == 42
      assert log.selected_option == 42
      assert log.selected_question == 42
      assert log.tier == 42
      assert log.unfinalised_chats == 42
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Others.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, %Log{} = log} = Others.update_log(log, @update_attrs)
      assert log.finalised_chats == 43
      assert log.selected_option == 43
      assert log.selected_question == 43
      assert log.tier == 43
      assert log.unfinalised_chats == 43
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = Others.update_log(log, @invalid_attrs)
      assert log == Others.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = Others.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Others.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = Others.change_log(log)
    end
  end
end
