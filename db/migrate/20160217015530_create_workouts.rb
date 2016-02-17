class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :datetime
      t.float :distance
      t.float :duration
      t.float :pace
      t.float :calories
      t.references :user, index: true, foreign_key: true
    end
  end
end
