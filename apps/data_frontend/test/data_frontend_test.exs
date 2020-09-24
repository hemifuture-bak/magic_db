defmodule DataFrontendTest do
  use ExUnit.Case
  doctest DataFrontend

  test "greets the world" do
    assert DataFrontend.hello() == :world
  end
end
