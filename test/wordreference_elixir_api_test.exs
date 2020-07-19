defmodule WordreferenceElixirApiTest do
  use ExUnit.Case
  doctest WordreferenceElixirApi

  test "greets the world" do
    assert WordreferenceElixirApi.hello() == :world
  end
end
