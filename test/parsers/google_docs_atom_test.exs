defmodule Feedraptor.Parser.GoogleDocsAtomTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  describe "will_parse?/1" do
    test "return true for Google Docs feed" do
      assert Feedraptor.Parser.GoogleDocsAtom.will_parse?(load_sample_google_docs_list_feed())
    end

    test "return false for Atom feed" do
      refute Feedraptor.Parser.GoogleDocsAtom.will_parse?(load_sample_atom_feed())
    end
  end

  setup do
    feed = Feedraptor.Parser.GoogleDocsAtom.parse(load_sample_google_docs_list_feed())
    {:ok, feed: feed}
  end

  test "should return a bunch of objects", %{feed: feed} do
    assert Enum.count(feed.entries) >= 1
  end

  test "should populate a title, interhited from the Atom entry", %{feed: feed} do
    assert feed.title != nil
  end
end
