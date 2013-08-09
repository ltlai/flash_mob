class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :user
      t.belongs_to :deck
      t.integer :num_correct
      t.integer :num_incorrect
      t.timestamps
    end
  end
end
