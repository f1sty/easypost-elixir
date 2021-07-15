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

  # def cast_keys(map) do
  #   map |> Enum.map(fn x -> cast(x) end)
  # end

  # def cast({k, v}) when is_map(v) do
  #   {String.to_atom(k), v}
  # end

  # def cast({k, v}) when is_list(v) do
  #   val =
  #     v
  #     |> Enum.map(fn
  #       x when is_map(x) -> x
  #       x -> cast(x)
  #     end)

  #   {String.to_atom(k), val}
  # end

  # def cast({k, v}) do
  #   {String.to_atom(k), v}
  # end

  # defp put_struct(v) do
  #   case v["object"] do
  #     "Address" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Batch" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "CarrierAccount" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "CustomsInfo" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "CustomsItem" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Parcel" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "PickupRate" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "PostageLabel" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Rate" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Refund" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Shipment" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "Tracker" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     "User" ->
  #       v |> Enum.map(fn x -> cast(x) end)

  #     _ ->
  #       v |> Enum.map(fn x -> cast(x) end)
  #   end
  # end
end
