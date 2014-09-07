class ImagesController < ApplicationController
  load_and_authorize_resource
  def create
    @image = Image.create(image_params)
    is_create = @image.save
    if is_create
      image_html = render_to_string( :partial => 'images/image_preview', :formats => [:html], :locals => { :image => @image } )
    else
      errors = render_to_string( :partial => 'images/errors', :formats => [:html], :locals => { :errors => @image.errors } )
    end
    render :json => { :image_html => image_html, :is_create => is_create, :img_errs => errors }
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render :json => { :image_id => @image.id }
  end

private

  def image_params
    params.require(:image).permit(:advert_id, :data)
  end
end
