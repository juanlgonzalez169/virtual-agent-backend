defmodule Chatbot.CMS.VirtualAssistant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "virtuals_assistants" do
    field :name, :string
    field :description, :string
    field :phone, :string


    has_many :virtuals_assistants_options, Chatbot.CMS.VirtualAssistantOption
    has_one :statistic, Chatbot.Others.Statistic
    has_one :log, Chatbot.Others.Log


    belongs_to :user, Chatbot.Users.User


    timestamps()
  end

  @doc false
  def changeset(virtual_assistant, attrs) do
    virtual_assistant
    |> cast(attrs, [:name, :description, :phone, :user_id])
    |> cast_assoc(:virtuals_assistants_options, required: true)
    |> validate_required([:name, :description, :phone])
    |> unique_constraint(:phone)
    |> validate_length(:phone, min: 11, max: 15)
    |> validate_format(:phone, ~r/[0-9]$/i)
  end
end
