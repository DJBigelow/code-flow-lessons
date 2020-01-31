# ---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
# ---
defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = user, inc_point_value) do
    user
    |> validate_is_active
    |> validate_at_least_age(16)
    |> check_name_blacklist
    |> increment_points(inc_point_value)
  end


  def validate_is_active(user) do
    case user do
      %{active: true} -> {:ok, user}
      _other -> {:error, "Not an active User"}
    end
  end


  def validate_at_least_age({:ok, %User{age: age} = user }, age_cutoff) when age >= age_cutoff do
    {:ok, user}
  end

  def validate_at_least_age({:ok, _user}, _age_cutoff) do
    {:error, "User age is below the cutoff"}
  end

  def validate_at_least_age(other, _) do
    other
  end




  def check_name_blacklist({:ok, %User{} = user}) do
    blacklist = ["Tom", "Tim", "Tammy"]
    if !Enum.member?(blacklist, user.name) do
      {:ok, user}
    else
      {:error, "User #{inspect(user.name)} is blacklisted"}
    end
  end

  def check_name_blacklist(other) do
    other
  end


  def increment_points({:ok, %User{points: user_points} = user}, points) do
    {:ok, %{user | points: user_points + points}}
  end

  def increment_points(other, _) do
    other
  end
end
