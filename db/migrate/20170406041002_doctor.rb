#
class Doctor < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :time_slots
      t.string :days
      t.references :user, foreign_key: true
      t.references :department, foreign_key: true
    end
  end
end
