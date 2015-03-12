require 'bcrypt'

class User < ActiveRecord::Base

  has_many :lists, dependent: :destroy

  validates :username, uniqueness: true
  validates :username, :password, presence: true



  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    # if new_password == nil || new_password == ""
    #   rescue self.errors[:base] << "Password needed"
    # else
      @password = Password.create(new_password)
      self.password_hash = @password
    # end
  end

end