defmodule Chatbot.CMS.VirtualAssistantTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "virtuals_assistants_tags" do
    field :identification, :string
    field :tag, :string


    belongs_to :virtual_assistant_question, Chatbot.CMS.VirtualAssistantQuestion


    timestamps()
  end

  @doc false
  def changeset(virtual_assistant_tag, attrs) do
    virtual_assistant_tag
    |> cast(attrs, [:identification, :tag])
    |> validate_required([:identification, :tag])
    |> assoc_constraint(:virtual_assistant_question)
  end
end
