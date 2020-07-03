defmodule Chatbot.Others do
  @moduledoc """
  The Others context.
  """

  import Ecto.Query, warn: false
  alias Chatbot.Repo

  alias Chatbot.Others.Statistic

  @doc """
  Returns the list of statistics.

  ## Examples

      iex> list_statistics()
      [%Statistic{}, ...]

  """
  def list_statistics do
    Repo.all(Statistic)
  end

  @doc """
  Gets a single statistic.

  Raises `Ecto.NoResultsError` if the Statistic does not exist.

  ## Examples

      iex> get_statistic!(123)
      %Statistic{}

      iex> get_statistic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_statistic!(id), do: Repo.get!(Statistic, id)

  @doc """
  Creates a statistic.

  ## Examples

      iex> create_statistic(%{field: value})
      {:ok, %Statistic{}}

      iex> create_statistic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_statistic(attrs \\ %{}) do
    %Statistic{}
    |> Statistic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a statistic.

  ## Examples

      iex> update_statistic(statistic, %{field: new_value})
      {:ok, %Statistic{}}

      iex> update_statistic(statistic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_statistic(%Statistic{} = statistic, attrs) do
    statistic
    |> Statistic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a statistic.

  ## Examples

      iex> delete_statistic(statistic)
      {:ok, %Statistic{}}

      iex> delete_statistic(statistic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_statistic(%Statistic{} = statistic) do
    Repo.delete(statistic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking statistic changes.

  ## Examples

      iex> change_statistic(statistic)
      %Ecto.Changeset{source: %Statistic{}}

  """
  def change_statistic(%Statistic{} = statistic) do
    Statistic.changeset(statistic, %{})
  end

  alias Chatbot.Others.Log

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Repo.all(Log)
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(Log, id)

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %Log{}}

  """
  def change_log(%Log{} = log) do
    Log.changeset(log, %{})
  end
end
