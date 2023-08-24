class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true

    validates :user_type, inclusion: { in: %w(doctor patient) }
    has_one :doctor
    has_one :patient
    before_create :build_association_based_on_user_type

  private

  def build_association_based_on_user_type
    if user_type == 'doctor'
      build_doctor
    elsif user_type == 'patient'
      build_patient
    end
  end
end
