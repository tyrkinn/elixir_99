defmodule Elixir99Test do
  use ExUnit.Case
  doctest Elixir99

  test "`last` returns error when list is empty" do
    assert {:error, _} = Elixir99.last([])
  end

  test "`last` returns last element" do
    assert {:ok, 5} = Elixir99.last([2, 3, 45, 5])
  end

  test "`last_two` returns error when list is empty" do
    assert {:error, _} = Elixir99.last_two([])
  end

  test "`last_two` returns error when list contains only one value" do
    assert {:error, _} = Elixir99.last_two([13])
  end

  test "`last_two` returns last two elements" do
    assert {:ok, {45, 5}} = Elixir99.last_two([2, 3, 45, 5])
  end
end
