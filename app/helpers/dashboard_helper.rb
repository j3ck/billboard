module DashboardHelper
  def adverts_count(state)
    current_user.adverts.where(state: state).size
  end
end
