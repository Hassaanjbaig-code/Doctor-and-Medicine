class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :specialization
      t.string :clinic_address
      t.string :clinic_name
      t.string :clinic_phone_number
      t.datetime :available_time_date
      t.datetime :end_of_duty
      
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
