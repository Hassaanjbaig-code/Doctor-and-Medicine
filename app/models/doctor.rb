class Doctor < ApplicationRecord
    belongs_to :user
    has_many :patients
    has_many :medicines, through: :patients
    has_many :appointments, through: :patients
    validates :available_time_date, presence: true
    validates :end_of_duty, presence: true
    validates :clinic_name, presence: true

    def doctor_name
        user.name
    end
end
