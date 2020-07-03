defmodule Chatbot.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string, null: false
      add :password_hash, :string
      add :user_plan, :string
      add :is_active, :boolean
      add :is_admin, :boolean
      add :avatar, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
