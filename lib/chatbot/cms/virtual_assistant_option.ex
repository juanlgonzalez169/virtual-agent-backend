defmodule Chatbot.CMS.VirtualAssistantOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "virtuals_assistants_options" do
    field :identification, :string
    field :option, :string


    has_many :virtuals_assistants_questions, Chatbot.CMS.VirtualAssistantQuestion


    belongs_to :virtual_assistant, Chatbot.CMS.VirtualAssistantOption

    timestamps()
  end

  @doc false
  def changeset(virtual_assistant_option, attrs) do
    virtual_assistant_option
    |> cast(attrs, [:identification, :option])
    |> validate_required([:identification, :option])
    |> assoc_constraint(:virtual_assistant)
    |> cast_assoc(:virtuals_assistants_questions, required: true)
  end
end
