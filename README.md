# Wordreference Elixir Api

### Simple way to turn wordreference.com to an API.

Usage example to translate hello word from English to Greek:

```elixir
iex> WordreferenceElixirApi.translate("hello", "en", "gr")
```
Returns {:ok, [translations]} or {:error, reason}
Some languages argument examples:

- English: en
- Greek: gr
- Spanish: es
- German: de
- Turkish: tr
- French: fr
- Italian: it
- Portuguese: pt
- Russian: ru
- Polish: pl
- Swedish: sv
- Nederlands: nl
