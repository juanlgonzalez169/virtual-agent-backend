defmodule Chatbot.Repo.Migrations.CreateVirtualsAssistants do
  use Ecto.Migration

  def change do
    create table(:virtuals_assistants) do
      add :phone, :string
      add :description, :string
      add :name, :string


      add :user_id, references(:users, on_delete: :delete_all), null: false


      timestamps()
    end

    create unique_index(:virtuals_assistants, [:phone])
    create index(:virtuals_assistants, [:user_id])
  end
end
