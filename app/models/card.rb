class Card < ActiveRecord::Base
  validates :question, presence: true
  validates :answer, presence: true
  validates :deck_id, presence: true

  belongs_to :deck

  def show
    self.shown = true
    self.save
  end
end