class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :question
      t.string :answer
      t.boolean :shown, default: false
      t.belongs_to :deck
      t.timestamps
    end
  end
end
