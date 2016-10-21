defmodule Regressions.I103NestedUnclosedTagsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "does not crash anymore" do 
    assert capture_io( :stderr, fn ->
      assert Earmark.to_html("<x>\n<y>") == "<x>\n<y>"
    end) == "<no file>:1: warning: Failed to find closing <x>\n<no file>:2: warning: Failed to find closing <y>\n"
  end
  
  test "treats inner and pending content" do 
    assert capture_io( :stderr, fn ->
      assert Earmark.to_html("<x>\ninner\n<y>\npending") == "<x>\ninner\n<y>\npending"
    end) == "<no file>:1: warning: Failed to find closing <x>\n<no file>:3: warning: Failed to find closing <y>\n"

  end
end
