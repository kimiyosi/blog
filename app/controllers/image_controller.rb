class ImageController < ApplicationController

  def show_image
    @image = Image.find_by(code: params[:code])
    send_data @image.img, type: 'image/jpeg', disposition: 'inline'
  end

end