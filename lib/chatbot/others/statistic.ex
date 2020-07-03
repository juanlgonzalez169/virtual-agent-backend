defmodule Chatbot.Others.Statistic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statistics" do
    field :received_messages, :integer, default: 0
    field :accepted_messages, :integer, default: 0
    field :invalid_messages, :integer, default: 0
    field :valid_messages, :integer, default: 0


    belongs_to :virtual_assistant, Chatbot.CMS.VirtualAssistant


    timestamps()


  end

  @doc false
  def changeset(statistic, attrs) do
    statistic
    |> cast(attrs, [:received_messages, :valid_messages, :invalid_messages, :accepted_messages])
    |> validate_required([:valid_messages, :invalid_messages, :accepted_messages])
  end
end
