defmodule Chatbot.Repo.Migrations.CreateVirtualsAssistantsOptions do
  use Ecto.Migration

  def change do
    create table(:virtuals_assistants_options) do
      add :identification, :string
      add :option, :string


      add :virtual_assistant_id, references(:virtuals_assistants, on_delete: :delete_all), null: false


      timestamps()
    end
    create index(:virtuals_assistants_options, [:virtual_assistant_id])
  end
end
