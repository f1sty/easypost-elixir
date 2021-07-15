defmodule Easypost.Helpers do
  def url(domain, path), do: Path.join([domain, path])

  def encode(struct) when is_struct(struct) do
    struct
    |> Map.from_struct()
    |> encode()
  end

  def encode(map) do
    q =
      map
      |> Enum.map(fn {k, v} -> process(k, v) end)
      |> List.flatten()
      |> URI.encode_query()
  end

  def process(acc, v) when is_map(v) do
    v
    |> Enum.map(fn {k, v} -> process(acc <> "[" <> to_string(k) <> "]", v) end)
  end

  def process(acc, v) when is_list(v) do
    v
    |> Enum.with_index()
    |> Enum.map(fn {v, i} -> process(acc <> "[" <> Integer.to_string(i) <> "]", v) end)
  end

  def process(acc, v) do
    {to_string(acc), v}
  end
end
