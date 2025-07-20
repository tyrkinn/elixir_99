defmodule HelpersTest do
  alias Elixir99.Helpers
  use ExUnit.Case
  doctest Elixir99.Helpers

  test "`take` should take n elements from start of the list" do
    assert [1, 2, 3] = Helpers.take([1, 2, 3, 4, 5], 3)
  end

  test "`take` should return all list if n >= length(xs)" do
    assert [1, 2, 3, 4, 5] = Helpers.take([1, 2, 3, 4, 5], 6)
  end

  test "`take` should return empty list if empty list provided" do
    assert [] = Helpers.take([], 6)
  end

  test "`drop` should drop n elements from start of the list" do
    assert [4, 5] = Helpers.drop([1, 2, 3, 4, 5], 3)
  end

  test "`drop` should return empty list if n >= length(xs)" do
    assert [] = Helpers.drop([1, 2, 3, 4, 5], 6)
  end

  test "`drop` should return empty list if empty list provided" do
    assert [] = Helpers.drop([], 6)
  end

  test "`drop` should return list back if 0 provided" do
    assert [1, 2, 3] = Helpers.drop([1, 2, 3], 0)
  end
end
