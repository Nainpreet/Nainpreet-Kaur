class Appointment < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.date :app_date
      t.date :date
      t.string :time_slots
      t.string :symptoms
      t.string :medications
      t.string :status, default: "Pending"
      t.integer :department_id
      t.references :user, foreign_key: true
      t.references :doctor, foreign_key: true
    end
  end
end
