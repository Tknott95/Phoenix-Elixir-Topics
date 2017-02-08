defmodule Discuss.Topic do
  use Discuss.Web, :model # Check web.ex file -___-

  schema "topics" do # Informing pgsql this model maps up to the topics table in my db. That table has a title which is type string
    field :title, :string # every topic should have col of title w/ type string
  end

  def changeset(struct, params \\ %{}) do # lays out changes going to be madde to get struct to where it is to where it needs to be
    struct # \\ %{} if object is nil then defaulted to empty map.. \\ defaulted
    |> cast(params, [:title])
    |> validate_required([:title]) # make sure title is there... if no title provided, display an err msg
  end    
end

# CHANGESET + FORM TEMPLATE = USABLE FORM  BEST FWIENDS FOHH SUCESSS THOOO
