defmodule Elixir99Test do
  use ExUnit.Case
  doctest Elixir99

  test "last returning error when list is empty" do
    assert {:error, _} = Elixir99.last([])
  end

  test "last returning last element" do
    assert {:ok, 5} = Elixir99.last([2, 3, 45, 5])
  end
end
