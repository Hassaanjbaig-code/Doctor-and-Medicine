class CreateMedicinesEats < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines_eats do |t|
      t.boolean :eat, default: false
      t.references :medicine, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
