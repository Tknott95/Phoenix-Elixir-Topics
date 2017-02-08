defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do # create a new table called topics
      add :title, :string # inside table, make sure column of title with type of string
    end
  end
end
