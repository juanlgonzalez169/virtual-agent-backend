defmodule Chatbot.Repo.Migrations.CreateStatistics do
  use Ecto.Migration

  def change do
    create table(:statistics) do
      add :received_messages, :integer
      add :valid_messages, :integer
      add :invalid_messages, :integer
      add :accepted_messages, :integer


      add :virtual_assistant_id, references(:virtuals_assistants, on_delete: :delete_all), null: false


      timestamps()
    end

  end
end
