defmodule Bigtable.Typed.Utils do
  def row_key_properties(update_pattern) do
    String.split(update_pattern, "#")
  end

  def build_update_key(access_patterns, prefix, map) do
    access_patterns
    |> Enum.reduce("#{prefix}", fn pattern, row_key ->
      [column_family | rest] = String.split(pattern, ".") |> Enum.map(&String.to_atom/1)

      value = build_lens(column_family, rest) |> Lens.one!(map)

      if(is_nil(value)) do
        throw("Unable to find key #{pattern} on #{inspect(map)}")
      end

      row_key <> "##{value}"
    end)
  end

  defp build_lens(root_key, access_keys) do
    Enum.reduce(access_keys, Lens.key(root_key), fn key, lens ->
      lens |> Lens.key(key)
    end)
  end
end