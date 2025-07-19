defmodule Elixir99Test do
  use ExUnit.Case
  doctest Elixir99

  test "`last` returns error when list is empty" do
    {:error, _} = Elixir99.last([])
  end

  test "`last` returns last element" do
    {:ok, 5} = Elixir99.last([2, 3, 45, 5])
  end

  test "`last_two` returns error when list is empty" do
    {:error, _} = Elixir99.last_two([])
  end

  test "`last_two` returns error when list contains only one value" do
    {:error, _} = Elixir99.last_two([13])
  end

  test "`last_two` returns last two elements" do
    {:ok, {45, 5}} = Elixir99.last_two([2, 3, 45, 5])
  end

  test "`nth` returns error when list is empty" do
    {:error, _} = Elixir99.nth([], 1)
  end

  test "`nth` returns error when list length <= n" do
    {:error, _} = Elixir99.nth([1, 2, 3], 3)
  end

  test "`nth` returns list nth elements" do
    {:ok, 3} = Elixir99.nth([1, 2, 3, 4, 5], 2)
  end

  test "`len` returns 0 on empty list" do
    0 = Elixir99.len([])
  end

  test "`len` returns length of list" do
    5 = Elixir99.len([1, 2, 3, 4, 5])
  end

  test "`reverse` on empty list returns empty list" do
    [] = Elixir99.reverse([])
  end

  test "`reverse` on list of one element returns this list back" do
    [1] = Elixir99.reverse([1])
  end

  test "`reverse` returns reversed list" do
    assert [3, 2, 1] = Elixir99.reverse([1, 2, 3])
  end
end
