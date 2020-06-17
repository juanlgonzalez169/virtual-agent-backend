defmodule Chatbot.CMS.VirtualAssistantQuestion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "virtuals_assistants_questions" do
    field :identification, :string
    field :question, :string


    has_many :virtuals_assistants_answers, Chatbot.CMS.VirtualAssistantAnswer
    has_many :virtuals_assistants_tags, Chatbot.CMS.VirtualAssistantTag


    belongs_to :virtual_assistant_option, Chatbot.CMS.VirtualAssistantOption


    timestamps()
  end

  @doc false
  def changeset(virtual_assistant_question, attrs) do
    virtual_assistant_question
    |> cast(attrs, [:identification, :question])
    |> validate_required([:identification, :question])
    |> assoc_constraint(:virtual_assistant_option)
    |> cast_assoc(:virtuals_assistants_answers, required: true)
    |> cast_assoc(:virtuals_assistants_tags, required: true)
  end
end
