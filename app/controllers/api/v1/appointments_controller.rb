class Api::V1::AppointmentsController < ApplicationController
  def index
    appointments = Appointment.all
    render json: appointments
  end

  def patient_appointments
    appointments = Appointment.where(patient_id: params[:id])
    render json: appointments
  end
  def doctor_appointment
    appointments = Appointment.where(doctor_id: params[:id])
    render json: appointments
  end

  def create
    appointment = Appointment.new(appointment_params)
    if appointment.appointment_date_time > DateTime.now
      if appointment.appointment_date_time < appointment.doctor.end_of_duty && doctor.available_time_date > DateTime.now
        if appointment.save!
          render json: appointment, status: :created
        else
          render json: appointment.errors, status: :unprocessable_entity
        end
      else
        render json: {message: "Doctor is not avalible in this Time"}, status: :unprocessable_entity
      end
    else
      render json: {message: "You can not enter date and time past"}, status: :unprocessable_entity
    end
end

  def edit
    appointment = Appointment.find(params[:id])
    if appointment.update(appointment_params)
      render json: appointment, status: :created, location: appointment
    else
        render json: appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    appointment = Appointment.find(params[:id])
    if appointment.destroy!
      render notice: "Successfully deleted", status: :ok
    else
      render json: appointment.errors, status: :unprocessable_entity, notice: "Failed to delete"
    end
  end

  private

  def appointment_params
    params.permit(:appointment_date_time, :reason_for_visit, :doctor_id, :patient_id)
  end
end
