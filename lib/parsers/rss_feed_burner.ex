defmodule Feedraptor.Parser.RSSFeedBurner do
  @moduledoc """
  Feed Parser for RSS Feedburner feeds

  ## Feed properties:

  * Title
  * Description
  * Url
  * Last Built
  * Entries

  ## Entry properties:

  * Title
  * Url
  * Author
  * Content
  * Summary
  * Published
  * Updated
  * Entry id
  * Categories
  """
  use Capuli

  element :title
  element :description
  element :link, as: :url
  element :lastbuilddate, as: :last_built
  elements :item, as: :entries, module: Feedraptor.Parser.RSSFeedBurner.Entry

  defmodule Entry do
    @moduledoc false
    alias Feedraptor.Helper

    defmodule Definition do
      @moduledoc false
      use Capuli

      element :title

      element :"feedburner:origlink", as: :url
      element :link, as: :url

      element :"dc:creator", as: :author
      element :author, as: :author
      element :"content:encoded", as: :content
      element :description, as: :summary

      element :pubdate, as: :published
      element :"dc:date", as: :published
      element :"dcterms:created", as: :published

      element :"dcterms:modified", as: :updated
      element :issued, as: :published
      elements :category, as: :categories

      element :guid, as: :entry_id
    end

    @doc false
    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields()
    end
  end

  @doc false
  def will_parse?(xml) do
    (xml =~ ~r/\<rss|\<rdf/) && (xml =~ ~r/feedburner/)
  end
end
