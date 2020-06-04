require 'open-uri'
require 'nokogiri'

class IndexController < ApplicationController
	def scrape(url)
  	  Nokogiri::HTML(open(url))
    end

    def grab_urls(doc)
  	  urls = []
  	  urls2 = []
  	  doc.css("td").each do |song|
  	  urls << song
  	end

  	  urls.each_with_index do |url, index|
  	  	if index == 2 || (index - 2) % 3 == 0
  	      if url.children.text
  	  	  	 urls2 << url.children.text.gsub(/"/, "").gsub(/\n/, "").strip
  	  	  end
  	    end
  	  end

  	  urls2.each do |foo|
  	  	p foo

  	  end
    end




	def index

	doc = scrape("https://weirdal.fandom.com/wiki/Complete_Song_List_(Wikipedia)")

	urls = grab_urls(doc)

	render 'index'
	end
end
