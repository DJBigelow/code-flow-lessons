# ---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
# ---
defmodule CodeFlow.Recursion do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Customers
  alias CodeFlow.Schemas.OrderItem
  alias CodeFlow.Schemas.Customer
  alias CodeFlow.Schemas.Item

  @doc """
  Sum a list of OrderItems to compute the order total.
  """
  def order_total(order_items) do
    do_order_total(order_items, 0.0)
  end

  defp do_order_total([%OrderItem{} = order | tail], acc) do
    do_order_total(tail, acc + order.item.price * order.quantity)
  end

  defp do_order_total([], acc), do: acc

  @doc """
  Count the number of active customers. Note: Normally this would be done with a
  query to an SQL database. This is just to practice conditionally incrementing
  a counter and looping using recursion.
  """
  def count_active(customers) do
    do_count_active(customers, 0)
  end

  defp do_count_active([%Customer{active: active} | tail], acc) do
    if active == true do
       do_count_active(tail, acc + 1)
    else
      do_count_active(tail, acc)
  end
  end

  defp do_count_active([], acc), do: acc

  @doc """
  Create the desired number of customers. Provide the number of customers to
  create. Something like this could be used in a testing setup.
  """
  def create_customers(number) do
    do_create_customers(number, 0)
  end

  defp do_create_customers(number, total) when total < number do
    # for simplicity, not handling a failed create
    {:ok, _customer} = Customers.create(%{name: "Customer #{number}"})
    do_create_customers(number, total + 1)
  end

  defp do_create_customers(_number, total) do
    "Created #{total} customers!"
  end

  @doc """
  Compute the value in the Fibonacci sequence for the number. If the number is
  "10", then the result is 10 plus the value of the 9th index of the fibonacci
  sequence.
  https://en.wikipedia.org/wiki/Fibonacci_number
  """
  def fibonacci(n) do
    cond  do
      n == 0 -> 0
      n == 1 -> 1
      n > 1 -> fibonacci(n - 1) + fibonacci(n - 2)
    end
  end


end
