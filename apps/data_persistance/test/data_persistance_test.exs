defmodule DataPersistanceTest do
  use ExUnit.Case
  doctest DataPersistance

  test "greets the world" do
    assert DataPersistance.hello() == :world
  end
end
