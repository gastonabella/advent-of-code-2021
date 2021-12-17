defmodule Day1 do
  @meassurements_path "./input.txt"

  def solution1 do
    @meassurements_path
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.scan(0, fn [prev, next], acc ->
      if cast(prev) < cast(next), do: acc + 1, else: acc
    end)
    |> Stream.take(-1)
    |> Enum.to_list()
    |> List.first()
  end

  defp cast(n) do
    n |> String.trim() |> String.to_integer()
  end
end

Day1.solution1() |> IO.puts()
