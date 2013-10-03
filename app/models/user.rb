class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validate :first_name,
           presence: true
  validate :last_name,
           presence: true


  def full_name
    "#{first_name} #{last_name}"
  end
  
  def to_s
    full_name
  end
end
