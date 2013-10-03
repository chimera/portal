class CheckInUser
  def self.call(rfid_code)
    user = User.find_by(rfid_code: rfid_code)
    CheckIn.new(user: user)
  end
end

class CheckInController < ApplicationController
  def index
    @check_ins = CheckIn.order('created_at DESC').limit(10)
  end

  def create
    check_in = CheckInUser.(params[:rfid_code])

    if check_in.save
      logger.debug "User checked in with valid RFID code: #{params[:rfid_code]}"
      redirect_to check_in_index_path, notice: "Welcome #{check_in.user.first_name}, come right on in!"
    else
      logger.warn "Failed Check In with RFID code: #{params[:rfid_code]}"
      redirect_to check_in_index_path, alert: 'Hey there, you can\'t come in with that kinda attitude!'
    end
  end
end

