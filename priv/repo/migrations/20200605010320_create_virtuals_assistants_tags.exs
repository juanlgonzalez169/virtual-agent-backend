defmodule Chatbot.Repo.Migrations.CreateVirtualsAssistantsTags do
  use Ecto.Migration

  def change do
    create table(:virtuals_assistants_tags) do
      add :identification, :string
      add :tag, :string


      add :virtual_assistant_question_id, references(:virtuals_assistants_questions, on_delete: :delete_all), null: false


      timestamps()
    end
    create index(:virtuals_assistants_tags, [:virtual_assistant_question_id])
  end
end
