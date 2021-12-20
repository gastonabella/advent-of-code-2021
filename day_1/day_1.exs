defmodule Day1 do
  @meassurements_path "./input.txt"

  def solution1 do
    start_stream()
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.scan(0, fn [prev, next], acc ->
      if cast(prev) < cast(next), do: acc + 1, else: acc
    end)
    |> last_from_stream()
  end

  def solution2 do
    start_stream()
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.scan(0, fn [prev, next], acc ->
      if sum_list(prev) < sum_list(next), do: acc + 1, else: acc
    end)
    |> last_from_stream()
  end

  defp cast(n) do
    n |> String.trim() |> String.to_integer()
  end

  defp sum_list([]), do: 0

  defp sum_list([elem | list]) do
    cast(elem) + sum_list(list)
  end

  defp start_stream do
    @meassurements_path
    |> Path.expand(__DIR__)
    |> File.stream!()
  end

  defp last_from_stream(stream) do
    stream
    |> Stream.take(-1)
    |> Enum.to_list()
    |> List.first()
  end
end

Day1.solution1() |> IO.puts()
Day1.solution2() |> IO.puts()
