defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  
  alias Discuss.Topic

  @doc """
    Display a list of topics
  """
  def index(conn, _params) do
    topics = Repo.all(Topic) # get all the topics in the database - remember we are using alias here so no need to write Discuss.Repo.all(Discuss.Topic)
  end

  @doc """
    Display the form to create a new topic
  """
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  @doc """
    Submit the form to create a new topic
  """
  def create(conn, %{"topic" => topic}) do
    # Create the changeset - it contains the data we want to insert
    changeset = Topic.changeset(%Topic{}, topic)
    
    # Insert the data in the changeset into the database
    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post) # data was successfully inserted
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset # If the insertion fails, show the user the form again
    end
  end

end
