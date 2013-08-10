class Card < ActiveRecord::Base
  validates :question, presence: true
  validates :answer, presence: true
  validates :deck_id, presence: true

  belongs_to :deck
end