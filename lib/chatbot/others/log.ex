defmodule Chatbot.Others.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :selected_option, :integer, default: 0
    field :tier, :integer, default: 0


    belongs_to :virtual_assistant, Chatbot.CMS.VirtualAssistant


    timestamps()


  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:tier, :selected_option])
    |> validate_required([:tier, :selected_option])
  end
end
