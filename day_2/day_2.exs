defmodule Day2 do
  @commands_path "./input.txt"

  def solution1 do
    start_stream()
    |> Stream.scan({0, 0}, fn command, pos ->
      execute(command, pos)
    end)
    |> last_from_stream()
    |> (fn {x, y} -> x * y end).()
  end

  defp cast(n) do
    n |> String.trim() |> String.to_integer()
  end

  defp start_stream do
    @commands_path
    |> Path.expand(__DIR__)
    |> File.stream!()
  end

  defp execute("forward" <> steps, {x, y}), do: {cast(steps) + x, y}
  defp execute("down" <> steps, {x, y}), do: {x, y + cast(steps)}
  defp execute("up" <> steps, {x, y}), do: {x, y - cast(steps)}

  defp last_from_stream(stream) do
    stream
    |> Stream.take(-1)
    |> Enum.to_list()
    |> List.first()
  end
end

Day2.solution1() |> IO.puts()
