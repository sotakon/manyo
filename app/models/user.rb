class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :admin_check

  def admin_check
    @user = User.all
    throw(:abort) if @user.count('true') <= 1
  end
end
