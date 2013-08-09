class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
end

# set incorrect and correct to default 0