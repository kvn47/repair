require 'digest'
class User < ActiveRecord::Base
  has_many :jobs, foreign_key: :master_id
  attr_accessor :password
  attr_accessible :username, :admin, :password, :password_confirmation
  validates :username, :presence => true, :uniqueness => true
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create 
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def is_admin?
    admin?
  end

  def not_admin?
    !admin?
  end
  
  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    user && user.has_password?(submitted_password) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) if !(password.blank? && !new_record?)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
