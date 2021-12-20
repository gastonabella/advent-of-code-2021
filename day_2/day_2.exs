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

  def solution2 do
    start_stream()
    |> Stream.scan({0, 0, 0}, fn command, pos ->
      execute_with_aim(command, pos)
    end)
    |> last_from_stream()
    |> (fn {_acc, x, y} -> x * y end).()
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

  defp execute_with_aim("forward" <> steps, {aim, x, y}) do
    steps = cast(steps)

    {aim, x + steps, y + aim * steps}
  end

  defp execute_with_aim("down" <> steps, {aim, x, y}), do: {aim + cast(steps), x, y}
  defp execute_with_aim("up" <> steps, {aim, x, y}), do: {aim - cast(steps), x, y}

  defp last_from_stream(stream) do
    stream
    |> Stream.take(-1)
    |> Enum.to_list()
    |> List.first()
  end
end

Day2.solution1() |> IO.puts()
Day2.solution2() |> IO.puts()
