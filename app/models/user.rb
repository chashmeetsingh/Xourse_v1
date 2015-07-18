class User < ActiveRecord::Base
	VALID_USERNAME_REGEX = /\A^[a-zA-Z0-9]+$\z/
    validates :username, presence: true, length: { maximum: 20 },
                                    format: { with: VALID_USERNAME_REGEX },
                                    uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 },  presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true,  length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }
	has_many :courses
end
