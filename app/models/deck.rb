class Deck < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :rounds
  has_many :users, through: :rounds
  has_many :cards

  def self.display_all
    @all_decks = Deck.all
    @all_decks.each do |n|
      puts "Hi, this is a deck: #{n.name}"
    end
  end  
end
