class Admin::CheckInsController < Admin::BaseController
  def index
    @check_ins = CheckIn.order('created_at DESC')
  end
end
