defmodule Chatbot.Repo.Migrations.CreateVirtualsAssistantsQuestions do
  use Ecto.Migration

  def change do
    create table(:virtuals_assistants_questions) do
      add :identification, :string
      add :question, :string


      add :virtual_assistant_option_id, references(:virtuals_assistants_options, on_delete: :delete_all), null: false


      timestamps()
    end
    create index(:virtuals_assistants_questions, [:virtual_assistant_option_id])
  end
end
