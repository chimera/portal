class Admin::DashboardController < Admin::BaseController
  def index
    @check_ins = CheckIn.order('created_at DESC').limit(10)
  end
end
