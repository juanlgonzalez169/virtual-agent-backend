defmodule Chatbot.CMS.VirtualAssistantAnswer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "virtuals_assistants_answers" do
    field :answer, :string
    field :identification, :string
    field :file, :string, default: "no-file"
    field :format, :string, default: "no-format"


    belongs_to :virtual_assistant_question, Chatbot.CMS.VirtualAssistantQuestion


    timestamps()
  end

  @doc false
  def changeset(virtual_assistant_answer, attrs) do
    virtual_assistant_answer
    |> cast(attrs, [:identification, :answer, :file, :format])
    |> validate_required([:identification, :answer])
    |> assoc_constraint(:virtual_assistant_question)
  end
end
