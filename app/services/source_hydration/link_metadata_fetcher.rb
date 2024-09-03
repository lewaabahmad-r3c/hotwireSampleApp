# app/services/link_metadata_service.rb
require 'open-uri'
require 'nokogiri'

module SourceHydration
  class LinkMetadataFetcher
    def self.fetch(url)
      new(url).fetch
    end

    def initialize(url)
      @url = url
    end

    def fetch
      html = URI.open(@url).read
      parse(html)
    rescue OpenURI::HTTPError => e
      Rails.logger.error "Failed to fetch URL: #{e.message}"
      nil
    end

    private

    def parse(html)
      doc = Nokogiri::HTML(html)
      {
        name: doc.at("meta[property='og:name']")&.[]('content'),
        description: doc.at("meta[property='og:description']")&.[]('content'),
        image: doc.at("meta[property='og:image']")&.[]('content'),
        url: @url
      }
    end
  end
end
