defmodule Elixir99.Helpers do
  @spec take(list(t), pos_integer()) :: list(t) when t: var
  def take(xs, n) do
    case xs do
      [] -> []
      [_ | tail] when n == 0 -> take(tail, n)
      [head | tail] -> [head | take(tail, n - 1)]
    end
  end

  @spec drop(list(t), pos_integer()) :: list(t) when t: var
  def drop(xs, n) do
    case xs do
      [] -> []
      xs when n == 0 -> xs
      [_ | tail] -> drop(tail, n - 1)
    end
  end
end
