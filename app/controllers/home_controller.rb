class HomeController < ApplicationController
  def index
    @albums = Album.where(published: true)
  end
end
