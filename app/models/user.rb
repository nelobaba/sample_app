class User < ApplicationRecord
  attr_accessor :remember_token

  # The above line means the two methods below

  # attr_writer, to write a value to the instance variable, say self.remember_token = value of interest
  # def remember_token = new_value
  #   @remember_token = new_value
  # end

  # attr_reader, to retrieve a value, say self.remember_token
  # def remember_token 
  #   @remember_token
  # end

    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token. User.new_token will also work
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remember when you use self. within a method, you are referring to instance variable attr reader or writer
  def remember
    # call the attribute writer method and pass new_value as return value of new_token method
    self.remember_token = User.new_token
    # updates a single attribute and saves the record without going the normal validations
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  # Also note that the remember_token here is a local variable while 
  # remember_digest is coming from the database and loks for that user record
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

   # Forgets a user.
   def forget
    update_attribute(:remember_digest, nil)
  end
end