class Admin::LogsController < Admin::AdminController
  load_and_authorize_resource
  before_action :set_advert, only: [:create, :new]
  respond_to :json

  def new
    @log = Log.new
    form_html = render_to_string(partial: 'admin/logs/form',
                                 formats: [:html],
                                 locals: { log: @log, advert: @advert })
    respond_with html: form_html
  end

  def create
    @log = @advert.logs.build(log_params.merge(editor_id: current_admin.id,
                                               editor_role: 'Admin',
                                               action: 'reject',
                                               last_state: @advert.state,
                                               current_state: 'rejected'))
    @advert.reject! if @advert.may_reject?
    is_create = @log.save
    if is_create
      advert_id = @advert.id
    else
      form_html = render_to_string(partial: 'admin/logs/form',
                                   formats: [:html],
                                   locals: { log: @log, advert: @advert })
    end
    render json: { create_status: is_create, advert_id: advert_id, html: form_html }
  end

  private

  def set_advert
    @advert = Advert.find(params[:advert_id])
  end

  def log_params
    params.require(:log).permit(:comment)
  end
end
