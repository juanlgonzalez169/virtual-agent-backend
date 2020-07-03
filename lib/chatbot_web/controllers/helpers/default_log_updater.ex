defmodule ChatbotWeb.DefaultOthersUpdater do
  alias Chatbot.Repo
  #import Ecto.Query, only: [from: 2]
  alias Chatbot.Others.{Log, Statistic}

  ## Log - tier

  def append_to_log_tier(log_id, tier) do
    log = Repo.get(Log, log_id)
      new_tier = tier + 1
      log
        |> Log.changeset(%{tier: new_tier})
        |> Repo.update()
  end

  def prepend_to_log_tier(log_id, tier) do
    log = Repo.get(Log, log_id)
      new_tier = tier - 1
      log
        |> Log.changeset(%{tier: new_tier})
        |> Repo.update()
  end

  def reset_log_tier(log_id) do
    log = Repo.get(Log, log_id)
      new_tier = 0
      log
        |> Log.changeset(%{tier: new_tier})
        |> Repo.update()
  end

  ## Log - selected_option

  def append_to_log_selected_option(log_id, selected_option) do
    log = Repo.get(Log, log_id)
      new_selected_option = selected_option
      log
        |> Log.changeset(%{selected_option: new_selected_option})
        |> Repo.update()
  end

  ## Log - finalised_chats

  def append_to_log_finalised_chats(log_id) do
    log = Repo.get(Log, log_id)
      log
        |> Log.changeset(%{finalised_chats: log.finalised_chats+1})
        |> Repo.update()
  end

  ## Log - unfinalised_chats

  def append_to_log_unfinalised_chats(log_id) do
    log = Repo.get(Log, log_id)
      log
        |> Statistic.changeset(%{unfinalised_chats: log.unfinalised_chats+1})
        |> Repo.update()
  end

  ## Statistic

  ## Append to statistic accepted messages
  def append_to_statistic_accepted_messages(statistic_id) do
    statistic = Repo.get(Statistic, statistic_id)
      statistic
        |> Statistic.changeset(%{accepted_messages: statistic.accepted_messages+1})
        |> Repo.update()
  end

  ## Append to statistic sendded messages
  def append_to_statistic_sendded_messages(statistic_id) do
    statistic = Repo.get(Statistic, statistic_id)
      statistic
        |> Statistic.changeset(%{sendded_messages: statistic.sendded_messages+1})
        |> Repo.update()
  end

  ## Append to statistic valid messages
  def append_to_statistic_valid_messages(statistic_id) do
    statistic = Repo.get(Statistic, statistic_id)
      statistic
        |> Statistic.changeset(%{valid_messages: statistic.valid_messages+1})
        |> Repo.update()
  end

  ## Append to statistic invalid messages
  def append_to_statistic_invalid_messages(statistic_id) do
    statistic = Repo.get(Statistic, statistic_id)
      statistic
        |> Statistic.changeset(%{invalid_messages: statistic.invalid_messages+1})
        |> Repo.update()
  end

end
