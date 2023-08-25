class Patient < ApplicationRecord
    belongs_to :user
    belongs_to :doctor
    has_many :appointments
    has_many :medicines
    has_many :medicines_eats, through: :medicines

    def patient_name
        user.name
    end
end
