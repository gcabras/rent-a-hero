class SuperherosController < ApplicationController
  def index
    @superheros = Superhero.all

    @markers = @superheros.geocoded.map do |superhero|
      {
        lat: superhero.latitude,
        lng: superhero.longitude,
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @superhero = Superhero.find(params[:id])
  end
end
