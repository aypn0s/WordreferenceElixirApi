defmodule WordreferenceElixirApi do
  @moduledoc """
    Simple way to turn wordreference.com to an API.
    Usage example to translate hello word from English to Greek:

      iex> WordreferenceElixirApi.translate("hello", "en", "gr")

    Returns {:ok, [translations]} or {:error, reason}

    Some languages argument examples:
    
    English: en
    
    Greek: gr
    
    Spanish: es
    
    German: de
    
    Turkish: tr
    
    French: fr
    
    Italian: it
    
    Portuguese: pt

    Russian: ru

    Polish: pl

    Swedish: sv

    Nederlands: nl
  """

  def translate(word, from, to) do
    url =
      cond do
        from == "en" && to == "es" ->
          "https://www.wordreference.com/es/translation.asp?tranword=#{word}"
        from == "es" && to == "en" ->
          "https://www.wordreference.com/es/en/translation.asp?spen=#{word}"
        true ->
          "https://www.wordreference.com/" <> from <> to <> "/" <> word
      end

    response = url |> request()

    case response do
      {:ok, body} ->
        {:ok, document} = Floki.parse_document(body)
        
        translations = 
          document
          |> Floki.find(".WRD tr.even .ToWrd")
          |> Enum.reduce([], fn x, acc ->
            case x do
              {_, _, this} when this |> length() == 2 ->
                {_, _, [word, _]} = x
                word = word |> String.trim()
                [word | acc]
              _ -> acc
            end
          end)
          |> Enum.reverse()

        {:ok, translations}

      {_, reason} ->
        {:error, reason}
    end
  end

  def request(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found :("}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
