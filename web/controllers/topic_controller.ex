defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  
  alias Discuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    # Create the changeset - it contains the data we want to insert
    changeset = Topic.changeset(%Topic{}, topic)
    
    # Insert the data in the changeset into the database
    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post) # data was successfully inserted
      {:error, changeset} -> IO.inspect(changeset) # data was not inserted
    end
  end
end
