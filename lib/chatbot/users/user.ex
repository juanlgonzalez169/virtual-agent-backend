defmodule Chatbot.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :user_plan, :string
    field :is_active, :boolean, default: true
    field :is_admin, :boolean, default: false
    field :avatar, :string

    pow_user_fields()


    has_many :virtuals_assistants, Chatbot.CMS.VirtualAssistant


    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name, :user_plan, :is_active, :is_admin, :avatar])
    |> validate_length(:first_name, min: 4, max: 15)
    |> validate_length(:last_name, min: 4, max: 15)
    |> validate_length(:user_plan, min: 4, max: 5)
  end
end
