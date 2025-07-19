defmodule Elixir99 do
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

  @spec len_aux(list(), integer()) :: integer()
  defp(len_aux(xs, n)) do
    case xs do
      [] -> n
      [_ | tail] -> len_aux(tail, n + 1)
    end
  end

  @spec len(list()) :: integer()
  def len(xs), do: len_aux(xs, 0)

  @spec reverse_aux(list(t), list(t)) :: list(t) when t: var
  defp reverse_aux(xs, acc) do
    case xs do
      [] -> acc
      [h | tail] -> reverse_aux(tail, [h] ++ acc)
    end
  end

  @spec reverse(list(t)) :: list(t) when t: var
  def reverse(xs), do: reverse_aux(xs, [])

  @spec palindrome(list()) :: boolean()
  def palindrome(xs), do: xs == reverse(xs)

  @type t_node(t) :: {:one, t} | {:many, list(t_node(t))}

  @spec flatten_aux(list(t_node(t)), list(t)) :: list(t) when t: var
  defp flatten_aux(xs, acc) do
    case xs do
      [] -> acc
      [{:one, x} | tail] -> flatten_aux(tail, acc ++ [x])
      [{:many, l} | tail] -> flatten_aux(tail, acc ++ flatten_aux(l, []))
    end
  end

  @spec flatten(list(t_node(t))) :: list(t) when t: var
  def flatten(xs), do: flatten_aux(xs, [])

  @spec compress_aux(list(t), t, list(t)) :: list(t) when t: var
  defp compress_aux(xs, cur, acc) do
    case xs do
      [] -> acc
      [h | tail] when h == cur -> compress_aux(tail, h, acc)
      [h | tail] -> compress_aux(tail, h, acc ++ [h])
    end
  end

  @spec compress(list(t)) :: list(t) when t: var
  def compress(xs) do
    case xs do
      [] -> []
      [x] -> [x]
      [h | tail] -> compress_aux(tail, h, [h])
    end
  end

  @spec pack_aux(list(t), list(t), list(list(t))) :: list(list(t)) when t: var
  defp pack_aux(xs, cur, acc) do
    case {xs, cur} do
      {[], c} ->
        acc ++ [c]

      {[h | tail], [x | _]} when h == x ->
        pack_aux(tail, cur ++ [h], acc)

      {[h | tail], cur} ->
        pack_aux(tail, [h], acc ++ [cur])
    end
  end

  @spec pack(list(t)) :: list(list(t)) when t: var
  def pack(xs) do
    case xs do
      [] -> []
      [x] -> [[x]]
      [h | tail] -> pack_aux(tail, [h], [])
    end
  end

  @type rle_pair(t) :: {integer(), t}

  @spec encode_aux(list(t), rle_pair(t), list(rle_pair(t))) :: list(rle_pair(t)) when t: var
  defp encode_aux(xs, pair, acc) do
    case {xs, pair} do
      {[], p} ->
        acc ++ [p]

      {[h | tail], {c, v}} when h == v ->
        encode_aux(tail, {c + 1, v}, acc)

      {[h | tail], p} ->
        encode_aux(tail, {1, h}, acc ++ [p])
    end
  end

  @spec encode(list(t)) :: list(rle_pair(t)) when t: var
  def encode(xs) do
    case xs do
      [] -> []
      [x] -> [{1, x}]
      [h | tail] -> encode_aux(tail, {1, h}, [])
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
      n -> repeat(x, n - 1, acc ++ [x])
    end
  end

  @spec replicate(list(t), integer()) :: list(t) when t: var
  def replicate(xs, n) do
    case xs do
      [] -> []
      [h | tail] -> repeat(h, n, []) ++ replicate(tail, n)
    end
  end

  @spec drop_aux(list(t), integer(), integer(), list(t)) :: list(t) when t: var
  defp drop_aux(xs, count, n, acc) do
    case xs do
      [] -> acc
      [_ | tail] when count == n -> drop_aux(tail, 1, n, acc)
      [h | tail] -> drop_aux(tail, count + 1, n, acc ++ [h])
    end
  end

  @spec drop(list(t), integer()) :: list(t) when t: var
  def drop(xs, n), do: drop_aux(xs, 1, n, [])
end
