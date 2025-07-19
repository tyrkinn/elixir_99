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
end
