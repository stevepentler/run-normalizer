class DropWorkoutTable < ActiveRecord::Migration
  def change
    drop_table :workouts
  end
end
