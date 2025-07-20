defmodule Elixir99Test do
  use ExUnit.Case
  doctest Elixir99

  test "`last` should return error when list is empty" do
    assert {:error, _} = Elixir99.last([])
  end

  test "`last` should return last element" do
    assert {:ok, 5} = Elixir99.last([2, 3, 45, 5])
  end

  test "`last_two` should return error when list is empty" do
    assert {:error, _} = Elixir99.last_two([])
  end

  test "`last_two` should return error when list contains only one value" do
    assert {:error, _} = Elixir99.last_two([13])
  end

  test "`last_two` should return last two elements" do
    assert {:ok, {45, 5}} = Elixir99.last_two([2, 3, 45, 5])
  end

  test "`nth` should return error when list is empty" do
    assert {:error, _} = Elixir99.nth([], 1)
  end

  test "`nth` should return error when list length <= n" do
    assert {:error, _} = Elixir99.nth([1, 2, 3], 3)
  end

  test "`nth` should return list nth elements" do
    assert {:ok, 3} = Elixir99.nth([1, 2, 3, 4, 5], 2)
  end

  test "`len` should return 0 on empty list" do
    assert 0 = Elixir99.len([])
  end

  test "`len` should return length of list" do
    assert 5 = Elixir99.len([1, 2, 3, 4, 5])
  end

  test "`reverse` on empty list should return empty list" do
    assert [] = Elixir99.reverse([])
  end

  test "`reverse` on list of one element should return this list back" do
    assert [1] = Elixir99.reverse([1])
  end

  test "`reverse` should return reversed list" do
    assert [3, 2, 1] = Elixir99.reverse([1, 2, 3])
  end

  test "`palindrome` should return true on empty list" do
    assert true = Elixir99.palindrome([])
  end

  test "`palindrome` should return true when list is palindrome" do
    assert Elixir99.palindrome([1, 2, 2, 1])
  end

  test "`palindrome` should return false when list is not palindrome" do
    refute Elixir99.palindrome([1, 2, 2, 3, 1])
  end

  test "`flatten` should return empty list when empty list provided" do
    assert [] = Elixir99.flatten([])
  end

  test "`flatten` should return just values when only `one` nodes provided" do
    assert [1, 2, 3] = Elixir99.flatten([{:one, 1}, {:one, 2}, {:one, 3}])
  end

  test "`flatten` should unwrap `many` node when it contains only `one` nodes inside" do
    assert [1, 2, 3] = Elixir99.flatten([{:many, [{:one, 1}, {:one, 2}, {:one, 3}]}])
  end

  test "`flatten` should unwrap nested `many` nodes" do
    assert [1, 2, 3, 4, 5] =
             Elixir99.flatten([
               {:many, [{:many, [{:one, 1}]}, {:many, [{:one, 2}, {:one, 3}]}]},
               {:many, [{:many, [{:many, [{:one, 4}]}]}, {:one, 5}]}
             ])
  end

  test "`compress` should return empty list when empty list provided" do
    assert [] = Elixir99.compress([])
  end

  test "`compress` should return list back when it contains one element" do
    assert [1] = Elixir99.compress([1])
  end

  test "`compress` should return compressed list" do
    assert [1, 2, 3, 4, 1, 4] = Elixir99.compress([1, 1, 1, 2, 3, 3, 4, 4, 1, 1, 4])
  end

  test "`pack` should return empty list when empty list provided" do
    assert [] = Elixir99.pack([])
  end

  test "`pack` should compress similar elements into inner lists" do
    assert [[1, 1, 1, 1]] = Elixir99.pack([1, 1, 1, 1])
  end

  test "`pack` should compress uniq elements into inner lists" do
    assert [[1], [2], [3], [4]] = Elixir99.pack([1, 2, 3, 4])
  end

  test "`pack` should compress similar and uniq elements into inner lists" do
    assert [[1, 1, 1, 1], [2], [3, 3], [4]] = Elixir99.pack([1, 1, 1, 1, 2, 3, 3, 4])
  end

  test "`encode` should return empty list when empty list provided" do
    assert [] = Elixir99.encode([])
  end

  test "`encode` should compress similar elements into rle pairs" do
    assert [{4, 1}] = Elixir99.encode([1, 1, 1, 1])
  end

  test "`encode` should compress uniq elements into rle pairs" do
    assert [{1, 1}, {1, 2}, {1, 3}, {1, 4}] = Elixir99.encode([1, 2, 3, 4])
  end

  test "`encode` should compress similar and uniq elements into rle pairs" do
    assert [{4, 1}, {1, 2}, {2, 3}, {1, 4}] = Elixir99.encode([1, 1, 1, 1, 2, 3, 3, 4])
  end

  test "`duplicate` should return empty list when empty list provided" do
    assert [] = Elixir99.duplicate([])
  end

  test "`duplicate` should return list with all elements duplicated" do
    assert [1, 1, 2, 2, 3, 3] = Elixir99.duplicate([1, 2, 3])
  end

  test "`replicate` should return empty list when empty list provided" do
    assert [] = Elixir99.replicate([], 3)
  end

  test "`replicate` should return list with all elements replicated n times" do
    assert [1, 1, 1, 2, 2, 2, 3, 3, 3] = Elixir99.replicate([1, 2, 3], 3)
  end

  test "`drop_nths` should return empty list when empty list provided" do
    assert [] = Elixir99.drop_nths([], 3)
  end

  test "`drop_nths` should remove every nth element from passed list" do
    assert [1, 2, 4, 5] = Elixir99.drop_nths([1, 2, 3, 4, 5, 6], 3)
  end

  test "`split` should return pair of n first elements and empty list if n >= length(xs)" do
    assert {[1, 2, 3, 4, 5, 6], []} = Elixir99.split([1, 2, 3, 4, 5, 6], 8)
  end

  test "`split` should return pair of first n elements and tail" do
    assert {[1, 2, 3, 4], [5, 6]} = Elixir99.split([1, 2, 3, 4, 5, 6], 4)
  end
end
