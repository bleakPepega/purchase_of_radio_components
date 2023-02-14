class PagesController < ApplicationController
  require 'nokogiri'

  def index
    require 'open-uri'
    url = 'http://www.cubecinema.com/programme'
    html = URI.open(url)

    @fields = %w[test pepega from telega]

  end
end
