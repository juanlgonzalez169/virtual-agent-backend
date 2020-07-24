defmodule Chatbot.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false
  alias Chatbot.Repo

  alias Chatbot.CMS.{VirtualAssistant, VirtualAssistantOption, VirtualAssistantQuestion, VirtualAssistantAnswer, VirtualAssistantTag}

  @doc """
  Returns the list of virtuals_assistants.

  ## Examples

      iex> list_virtuals_assistants()
      [%VirtualAssistant{}, ...]

  """
  def list_virtuals_assistants do
    VirtualAssistant
    |> Repo.all()
  end

  def list_fully_virtuals_assistants do
    VirtualAssistant
    |> Repo.all()
    |> Repo.preload(virtuals_assistants_options: [virtuals_assistants_questions: [:virtuals_assistants_tags, :virtuals_assistants_answers]])
  end

  @doc """
  Gets a single virtual_assistant.

  Raises `Ecto.NoResultsError` if the Virtual assistant does not exist.

  ## Examples

      iex> get_virtual_assistant!(123)
      %VirtualAssistant{}

      iex> get_virtual_assistant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_assistant!(id) do
    VirtualAssistant
    |> Repo.get!(id)
  end

  @spec get_fully_virtual_assistant!(any) ::
          nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  def get_fully_virtual_assistant!(id) do
    VirtualAssistant
    |> Repo.get!(id)
    |> Repo.preload(virtuals_assistants_options: [virtuals_assistants_questions: [:virtuals_assistants_tags, :virtuals_assistants_answers]])
  end
  @doc """
  Creates a virtual_assistant.

  ## Examples

      iex> create_virtual_assistant(%{field: value})
      {:ok, %VirtualAssistant{}}

      iex> create_virtual_assistant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_assistant(attrs \\ %{}) do
    %VirtualAssistant{}
    |> VirtualAssistant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_assistant.

  ## Examples

      iex> update_virtual_assistant(virtual_assistant, %{field: new_value})
      {:ok, %VirtualAssistant{}}

      iex> update_virtual_assistant(virtual_assistant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_assistant(%VirtualAssistant{} = virtual_assistant, attrs) do
    virtual_assistant
    |> VirtualAssistant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virtual_assistant.

  ## Examples

      iex> delete_virtual_assistant(virtual_assistant)
      {:ok, %VirtualAssistant{}}

      iex> delete_virtual_assistant(virtual_assistant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_assistant(%VirtualAssistant{} = virtual_assistant) do
    Repo.delete(virtual_assistant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_assistant changes.

  ## Examples

      iex> change_virtual_assistant(virtual_assistant)
      %Ecto.Changeset{source: %VirtualAssistant{}}

  """
  def change_virtual_assistant(%VirtualAssistant{} = virtual_assistant) do
    VirtualAssistant.changeset(virtual_assistant, %{})
  end

  alias Chatbot.CMS.VirtualAssistantOption

  @doc """
  Returns the list of virtuals_assistants_options.

  ## Examples

      iex> list_virtuals_assistants_options()
      [%VirtualAssistantOption{}, ...]

  """
  def list_virtuals_assistants_options do
    Repo.all(VirtualAssistantOption)
  end

  @doc """
  Gets a single virtual_assistant_option.

  Raises `Ecto.NoResultsError` if the Virtual assistant option does not exist.

  ## Examples

      iex> get_virtual_assistant_option!(123)
      %VirtualAssistantOption{}

      iex> get_virtual_assistant_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_assistant_option!(id), do: Repo.get!(VirtualAssistantOption, id)

  @doc """
  Creates a virtual_assistant_option.

  ## Examples

      iex> create_virtual_assistant_option(%{field: value})
      {:ok, %VirtualAssistantOption{}}

      iex> create_virtual_assistant_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_assistant_option(attrs \\ %{}) do
    %VirtualAssistantOption{}
    |> VirtualAssistantOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_assistant_option.

  ## Examples

      iex> update_virtual_assistant_option(virtual_assistant_option, %{field: new_value})
      {:ok, %VirtualAssistantOption{}}

      iex> update_virtual_assistant_option(virtual_assistant_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_assistant_option(%VirtualAssistantOption{} = virtual_assistant_option, attrs) do
    virtual_assistant_option
    |> VirtualAssistantOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virtual_assistant_option.

  ## Examples

      iex> delete_virtual_assistant_option(virtual_assistant_option)
      {:ok, %VirtualAssistantOption{}}

      iex> delete_virtual_assistant_option(virtual_assistant_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_assistant_option(%VirtualAssistantOption{} = virtual_assistant_option) do
    Repo.delete(virtual_assistant_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_assistant_option changes.

  ## Examples

      iex> change_virtual_assistant_option(virtual_assistant_option)
      %Ecto.Changeset{source: %VirtualAssistantOption{}}

  """
  def change_virtual_assistant_option(%VirtualAssistantOption{} = virtual_assistant_option) do
    VirtualAssistantOption.changeset(virtual_assistant_option, %{})
  end

  alias Chatbot.CMS.VirtualAssistantQuestion

  @doc """
  Returns the list of virtuals_assistants_questions.

  ## Examples

      iex> list_virtuals_assistants_questions()
      [%VirtualAssistantQuestion{}, ...]

  """
  def list_virtuals_assistants_questions do
    Repo.all(VirtualAssistantQuestion)
  end

  @doc """
  Gets a single virtual_assistant_question.

  Raises `Ecto.NoResultsError` if the Virtual assistant question does not exist.

  ## Examples

      iex> get_virtual_assistant_question!(123)
      %VirtualAssistantQuestion{}

      iex> get_virtual_assistant_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_assistant_question!(id), do: Repo.get!(VirtualAssistantQuestion, id)

  @doc """
  Creates a virtual_assistant_question.

  ## Examples

      iex> create_virtual_assistant_question(%{field: value})
      {:ok, %VirtualAssistantQuestion{}}

      iex> create_virtual_assistant_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_assistant_question(attrs \\ %{}) do
    %VirtualAssistantQuestion{}
    |> VirtualAssistantQuestion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_assistant_question.

  ## Examples

      iex> update_virtual_assistant_question(virtual_assistant_question, %{field: new_value})
      {:ok, %VirtualAssistantQuestion{}}

      iex> update_virtual_assistant_question(virtual_assistant_question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_assistant_question(%VirtualAssistantQuestion{} = virtual_assistant_question, attrs) do
    virtual_assistant_question
    |> VirtualAssistantQuestion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virtual_assistant_question.

  ## Examples

      iex> delete_virtual_assistant_question(virtual_assistant_question)
      {:ok, %VirtualAssistantQuestion{}}

      iex> delete_virtual_assistant_question(virtual_assistant_question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_assistant_question(%VirtualAssistantQuestion{} = virtual_assistant_question) do
    Repo.delete(virtual_assistant_question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_assistant_question changes.

  ## Examples

      iex> change_virtual_assistant_question(virtual_assistant_question)
      %Ecto.Changeset{source: %VirtualAssistantQuestion{}}

  """
  def change_virtual_assistant_question(%VirtualAssistantQuestion{} = virtual_assistant_question) do
    VirtualAssistantQuestion.changeset(virtual_assistant_question, %{})
  end

  alias Chatbot.CMS.VirtualAssistantAnswer

  @doc """
  Returns the list of virtuals_assistants_answers.

  ## Examples

      iex> list_virtuals_assistants_answers()
      [%VirtualAssistantAnswer{}, ...]

  """
  def list_virtuals_assistants_answers do
    Repo.all(VirtualAssistantAnswer)
  end

  @doc """
  Gets a single virtual_assistant_answer.

  Raises `Ecto.NoResultsError` if the Virtual assistant answer does not exist.

  ## Examples

      iex> get_virtual_assistant_answer!(123)
      %VirtualAssistantAnswer{}

      iex> get_virtual_assistant_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_assistant_answer!(id), do: Repo.get!(VirtualAssistantAnswer, id)

  @doc """
  Creates a virtual_assistant_answer.

  ## Examples

      iex> create_virtual_assistant_answer(%{field: value})
      {:ok, %VirtualAssistantAnswer{}}

      iex> create_virtual_assistant_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_assistant_answer(attrs \\ %{}) do
    %VirtualAssistantAnswer{}
    |> VirtualAssistantAnswer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_assistant_answer.

  ## Examples

      iex> update_virtual_assistant_answer(virtual_assistant_answer, %{field: new_value})
      {:ok, %VirtualAssistantAnswer{}}

      iex> update_virtual_assistant_answer(virtual_assistant_answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_assistant_answer(%VirtualAssistantAnswer{} = virtual_assistant_answer, attrs) do
    virtual_assistant_answer
    |> VirtualAssistantAnswer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virtual_assistant_answer.

  ## Examples

      iex> delete_virtual_assistant_answer(virtual_assistant_answer)
      {:ok, %VirtualAssistantAnswer{}}

      iex> delete_virtual_assistant_answer(virtual_assistant_answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_assistant_answer(%VirtualAssistantAnswer{} = virtual_assistant_answer) do
    Repo.delete(virtual_assistant_answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_assistant_answer changes.

  ## Examples

      iex> change_virtual_assistant_answer(virtual_assistant_answer)
      %Ecto.Changeset{source: %VirtualAssistantAnswer{}}

  """
  def change_virtual_assistant_answer(%VirtualAssistantAnswer{} = virtual_assistant_answer) do
    VirtualAssistantAnswer.changeset(virtual_assistant_answer, %{})
  end

  alias Chatbot.CMS.VirtualAssistantTag

  @doc """
  Returns the list of virtuals_assistants_tags.

  ## Examples

      iex> list_virtuals_assistants_tags()
      [%VirtualAssistantTag{}, ...]

  """
  def list_virtuals_assistants_tags do
    Repo.all(VirtualAssistantTag)
  end

  @doc """
  Gets a single virtual_assistant_tag.

  Raises `Ecto.NoResultsError` if the Virtual assistant tag does not exist.

  ## Examples

      iex> get_virtual_assistant_tag!(123)
      %VirtualAssistantTag{}

      iex> get_virtual_assistant_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_assistant_tag!(id), do: Repo.get!(VirtualAssistantTag, id)

  @doc """
  Creates a virtual_assistant_tag.

  ## Examples

      iex> create_virtual_assistant_tag(%{field: value})
      {:ok, %VirtualAssistantTag{}}

      iex> create_virtual_assistant_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_assistant_tag(attrs \\ %{}) do
    %VirtualAssistantTag{}
    |> VirtualAssistantTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_assistant_tag.

  ## Examples

      iex> update_virtual_assistant_tag(virtual_assistant_tag, %{field: new_value})
      {:ok, %VirtualAssistantTag{}}

      iex> update_virtual_assistant_tag(virtual_assistant_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_assistant_tag(%VirtualAssistantTag{} = virtual_assistant_tag, attrs) do
    virtual_assistant_tag
    |> VirtualAssistantTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virtual_assistant_tag.

  ## Examples

      iex> delete_virtual_assistant_tag(virtual_assistant_tag)
      {:ok, %VirtualAssistantTag{}}

      iex> delete_virtual_assistant_tag(virtual_assistant_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_assistant_tag(%VirtualAssistantTag{} = virtual_assistant_tag) do
    Repo.delete(virtual_assistant_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_assistant_tag changes.

  ## Examples

      iex> change_virtual_assistant_tag(virtual_assistant_tag)
      %Ecto.Changeset{source: %VirtualAssistantTag{}}

  """
  def change_virtual_assistant_tag(%VirtualAssistantTag{} = virtual_assistant_tag) do
    VirtualAssistantTag.changeset(virtual_assistant_tag, %{})
  end
end
