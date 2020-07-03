defmodule Chatbot.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :tier, :integer
      add :selected_option, :integer


      add :virtual_assistant_id, references(:virtuals_assistants, on_delete: :delete_all), null: false


      timestamps()
    end

  end
end
