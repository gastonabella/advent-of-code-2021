defmodule Day3 do
  @binaries_path "./input.txt"

  def solution1 do
    start_stream()
    |> Stream.scan(List.duplicate(0, 12), fn binaries, acc ->
      binaries
      |> String.codepoints()
      |> Enum.zip(acc)
      |> Enum.map(fn
        {"0", acc} -> acc - 1
        {"1", acc} -> acc + 1
      end)
    end)
    |> last_from_stream()
    |> Enum.map(fn
      count when count > 0 -> {1, 0}
      _bit -> {0, 1}
    end)
    |> Enum.unzip()
    |> (fn {gamma, epsilon} -> bits_list_to_int(gamma) * bits_list_to_int(epsilon) end).()
  end

  defp start_stream do
    @binaries_path
    |> Path.expand(__DIR__)
    |> File.stream!()
  end

  defp last_from_stream(stream) do
    stream
    |> Stream.take(-1)
    |> Enum.to_list()
    |> List.first()
  end

  defp bits_list_to_int(list) do
    list
    |> Enum.join()
    |> String.to_integer(2)
  end
end

Day3.solution1() |> IO.inspect()
# Day3.solution2() |> IO.puts()
