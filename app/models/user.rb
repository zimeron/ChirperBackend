class User < ApplicationRecord
    # Requires that passwords be digested before storing
    has_secure_password

    # Requires username uniqueness
    validates :username, presence: true, uniqueness: true
end
