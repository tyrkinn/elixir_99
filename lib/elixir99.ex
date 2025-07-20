defmodule Elixir99 do
  import Elixir99.Helpers, only: [drop: 2, take: 2]
  @spec last(list(t)) :: t when t: var
  def last(xs) do
    case xs do
      [] -> {:error, "List is empty"}
      [x] -> {:ok, x}
      [_ | tail] -> last(tail)
    end
  end

  @spec last_two(list(t)) :: {t, t} when t: var
  def last_two(xs) do
    case xs do
      [] -> {:error, "List is empty"}
      [_] -> {:error, "List should contain at least 2 elements"}
      [x, y] -> {:ok, {x, y}}
      [_ | tail] -> last_two(tail)
    end
  end

  @spec nth(list(t), integer()) :: t when t: var
  def nth(xs, n) do
    case {xs, n} do
      _ when length(xs) <= n or n < 0 ->
        {:error, "Invalid index"}

      {[x | _], 0} ->
        {:ok, x}

      {[_ | tail], n} ->
        nth(tail, n - 1)
    end
  end

  @spec len(list(), integer()) :: integer()
  def len(xs, acc \\ 0) do
    case xs do
      [] -> acc
      [_ | tail] -> len(tail, acc + 1)
    end
  end

  @spec reverse(list(t), list()) :: list(t) when t: var
  def reverse(xs, acc \\ []) do
    case xs do
      [] -> acc
      [h | tail] -> reverse(tail, [h | acc])
    end
  end

  @spec palindrome(list()) :: boolean()
  def palindrome(xs), do: xs == reverse(xs)

  @type t_node(t) :: {:one, t} | {:many, list(t_node(t))}

  @spec flatten(list(t_node(t)), list(t)) :: list(t) when t: var
  def flatten(xs, acc \\ []) do
    case xs do
      [] -> reverse(acc)
      [{:one, x} | tail] -> flatten(tail, [x | acc])
      [{:many, l} | tail] -> flatten(tail, reverse(flatten(l, [])) ++ acc)
    end
  end

  @spec compress(list(t), t, list(t)) :: list(t) when t: var
  defp compress(xs, cur, acc) do
    case xs do
      [] -> reverse(acc)
      [h | tail] when h == cur -> compress(tail, h, acc)
      [h | tail] -> compress(tail, h, [h | acc])
    end
  end

  @spec compress(list(t)) :: list(t) when t: var
  def compress(xs) do
    case xs do
      [] -> []
      [x] -> [x]
      [h | tail] -> compress(tail, h, [h])
    end
  end

  @spec pack(list(t), list(t), list(list(t))) :: list(list(t)) when t: var
  defp pack(xs, cur, acc) do
    case {xs, cur} do
      {[], c} ->
        [c | acc] |> reverse

      {[h | tail], [x | _]} when h == x ->
        pack(tail, [h | cur], acc)

      {[h | tail], cur} ->
        pack(tail, [h], [reverse(cur) | acc])
    end
  end

  @spec pack(list(t)) :: list(list(t)) when t: var
  def pack(xs) do
    case xs do
      [] -> []
      [x] -> [[x]]
      [h | tail] -> pack(tail, [h], [])
    end
  end

  @type rle_pair(t) :: {integer(), t}

  @spec encode(list(t), rle_pair(t), list(rle_pair(t))) :: list(rle_pair(t)) when t: var
  defp encode(xs, pair, acc) do
    case {xs, pair} do
      {[], p} ->
        reverse([p | acc])

      {[h | tail], {c, v}} when h == v ->
        encode(tail, {c + 1, v}, acc)

      {[h | tail], p} ->
        encode(tail, {1, h}, [p | acc])
    end
  end

  @spec encode(list(t)) :: list(rle_pair(t)) when t: var
  def encode(xs) do
    case xs do
      [] -> []
      [x] -> [{1, x}]
      [h | tail] -> encode(tail, {1, h}, [])
    end
  end

  @spec duplicate(list(t)) :: list(t) when t: var
  def duplicate(xs) do
    case xs do
      [] -> []
      [h | tail] -> [h, h | duplicate(tail)]
    end
  end

  @spec repeat(t, integer(), list(t)) :: list(t) when t: var
  defp repeat(x, n, acc) do
    case n do
      0 -> acc
      n -> repeat(x, n - 1, [x | acc])
    end
  end

  @spec replicate(list(t), integer()) :: list(t) when t: var
  def replicate(xs, n) do
    case xs do
      [] -> []
      [h | tail] -> repeat(h, n, []) ++ replicate(tail, n)
    end
  end

  @spec drop_nths(list(t), integer(), integer(), list(t)) :: list(t) when t: var
  def drop_nths(xs, n, count \\ 1, acc \\ []) do
    case xs do
      [] -> reverse(acc)
      [_ | tail] when count == n -> drop_nths(tail, n, 1, acc)
      [h | tail] -> drop_nths(tail, n, count + 1, [h | acc])
    end
  end

  @spec split(list(t), integer()) :: {list(t), list(t)} when t: var
  def split(xs, n, acc \\ []) do
    case {xs, n} do
      {[], _} -> {reverse(acc), []}
      {xs, 0} -> {reverse(acc), xs}
      {[head | tail], n} -> split(tail, n - 1, [head | acc])
    end
  end

  @spec slice(list(t), integer(), integer()) :: list(t) when t: var
  def slice(xs, from, to) do
    xs
    |> drop(from)
    |> take(to - from + 1)
  end
end
