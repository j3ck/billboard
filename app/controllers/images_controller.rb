class ImagesController < ApplicationController
  def create
    @image = Image.create(image_params)
    @image.save
    image_html = render_to_string( :partial => 'images/image_preview', :formats => [:html], :locals => { :image => @image } )
    render :json => { :image_html => image_html }
  end

private

  def image_params
    params.require(:image).permit(:advert_id, :data)
  end
end
