class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck

  def record_correct
    self.num_correct += 1
    self.save
  end

  def record_incorrect
    self.num_incorrect += 1
    self.save
  end
end