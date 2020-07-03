defmodule Chatbot.Repo.Migrations.CreateVirtualsAssistantsAnswers do
  use Ecto.Migration

  def change do
    create table(:virtuals_assistants_answers) do
      add :identification, :string
      add :answer, :string
      add :file, :string
      add :format, :string


      add :virtual_assistant_question_id, references(:virtuals_assistants_questions, on_delete: :delete_all), null: false


      timestamps()
    end
    create index(:virtuals_assistants_answers, [:virtual_assistant_question_id])
  end
end
