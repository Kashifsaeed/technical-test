class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  validates :email,:username, presence: true, uniqueness: true
  validates :username, length: { maximum: 15 }

  PASSWORD_FORMAT = /\A
    (?=.{10,})         # Must contain 10 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password, confirmation: true, presence: true, length: { minimum: 10 }, format: {
          with: PASSWORD_FORMAT,
          message: "must contain a lowercase letter, an uppercase letter, a digit, and a special character!"
        }
  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
