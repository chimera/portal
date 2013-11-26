require 'serialport'

class CheckInUser
  class UnauthorizedRFIDCode < StandardError; end

  def self.call(rfid_code)
    user = User.find_by(rfid_code: rfid_code)
    if user.present?
      unlock
      check_in = CheckIn.create!(user: user)
      Rails.logger.debug "User checked in with valid RFID code: #{rfid_code}"
      check_in
    else
      raise UnauthorizedRFIDCode, "Code #{rfid_code} is not authorized"
    end
  end

  def self.unlock
    port = SerialPort.new "/dev/tty.usbmodem411", 9600
    port.write "1\n"
    port.close
  end
end

class CheckInsController < ApplicationController
  def index
    @check_ins = CheckIn.order('created_at DESC').limit(10)
  end

  def create
    check_in = CheckInUser.(params[:rfid_code])
    redirect_to check_ins_path, notice: "Welcome #{check_in.user.first_name}, come right on in!"
  rescue CheckInUser::UnauthorizedRFIDCode
    logger.warn "Failed Check In with RFID code: #{params[:rfid_code]}"
    redirect_to check_ins_path, alert: 'Hey there, you can\'t come in with that kinda attitude!'
  end
end

