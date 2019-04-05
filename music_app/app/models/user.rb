# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord
    attr_reader :password

    validates :email, :password_digest, :session_token, presence: true
    validates :email, :session_token, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    after_initialize :ensure_session_token

    def self.find_by_credentials(email, password)
        u = User.find_by(email: email)
        if u && u.is_password?(password)
            return u
        end
        nil
    end

    def self.generate_session_token
        # use SecureRandom class to generate a random 16bit string
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        # use class helper method to create a new session_token
        self.session_token = self.class.generate_session_token
        self.save!          # save user so new session_token gets updated in database
        self.session_token  # return new session token
    end

    def ensure_session_token
        # lazy assignment : if a token already exists, use it, no need to generate a new one
        self.session_token ||= self.class.generate_session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(@password)
    end

    def is_password?(password)
        # verify if user password saved in ivar is equivalent to the encrypted version stored in database
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
end
