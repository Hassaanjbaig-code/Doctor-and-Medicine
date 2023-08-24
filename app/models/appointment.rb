class Appointment < ApplicationRecord
    belongs_to :doctor
    belongs_to :patient
    # before_validation :convert_to_time_zone
    # before_action :checking_doctor_is_available
    # before_action :checking_date_time_not_be_past

    validates :appointment_date_time, presence: true
    validates :reason_for_visit, presence: true

    # def convert_to_time_zone
    #     # Convert appointment_date_time to doctor's time zone
    #     self.appointment_date_time = self.appointment_date_time.in_time_zone(self.doctor.available_time_date) if self.doctor
    # end

    def checking_date_time_not_be_past
        if appointment_date_time && appointment_date_time < DateTime.now
            errors.add(:appointment_date_time, "can't be in the past")
        end
    end
        
     def checking_doctor_is_available
      doctor = Doctor.find_by(id: self.doctor_id)
      
      if appointment_date_time &&
         (doctor.available_time_date > self.appointment_date_time.in_time_zone &&
          doctor.end_of_duty < self.appointment_date_time.in_time_zone)
        errors.add(:doctor, "is not available at this time")
        return false
      else 
        return true
      end
    end


end
