class User < ActiveRecord::Base

  has_many :rounds
  has_many :decks, through: :rounds

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  
  def self.authenticate(username, password)
    current_user = User.find_by_username(username)
    if current_user.nil?
      return nil
    elsif current_user.password == password
      return current_user
    else
      return nil
    end
  end
end