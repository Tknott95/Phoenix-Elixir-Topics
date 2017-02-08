defmodule Discuss.TopicController do
  use Discuss.Web, :controller # Line used for elixir class inheritence pretty much

  alias Discuss.Topic # Topic below used to be Discuss.Topic but do to this it is now only Topic (the alias)

  def index(conn, _params) do
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end 

  def new(conn, _params) do # conn - connection    params - parameters
    changeset = Topic.changeset(%Topic{}, %{}) # (struct, params)
    
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do # Pattern Matching to take topic out of params
     changeset = Topic.changeset(%Topic{}, topic)

     case Repo.insert(changeset) do # Will Insert record into DB
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset # changeet that just failed getting returned
     end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) # arg of type to fetch from db and id 
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    # old_topic = Repo.get(Topic, topic_id)
    # changeset = Topic.changeset(old_topic, topic)

    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

end