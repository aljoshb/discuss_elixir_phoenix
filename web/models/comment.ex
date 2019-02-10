defmodule Discuss.Comment do
  use Discuss.Web, :model

  @derive {Poison.Encoder, only: [:content]} # Tells Poison to only try to convert the content field into json, nothing else

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.User
    belongs_to :topic, Discuss.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
