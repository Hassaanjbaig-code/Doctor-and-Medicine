class Api::V1::DoctorsController < ApplicationController
  def index
  @doctors = Doctor.all
  render json: @doctors.as_json(only: [:id, :specialization, :clinic_address, :clinic_name, :clinic_phone_number, :available_time_date, :end_of_duty], methods: [:doctor_name]), status: :ok
end

  def show
    @doctor = Doctor.find(params[:id])
    render json: @doctor.as_json(only: [:id, :specialization, :clinic_address, :clinic_name, :clinic_phone_number, :available_time_date, :end_of_duty], methods: [:doctor_name])
  end

  def create
    @doctor = Doctor.new(doctor_params)
     if @doctor.available_time_date < @doctor.end_of_duty && 
        @doctor.available_time_date > DateTime.now 
    if @doctor.save
      render json: @doctor, status: :created
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  else
    render json: {message: "Please enter valid time"}, status: :unprocessable_entity
  end
  end

  def edit
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doctor_params)
      render json: @doctor, status: :created, location: @doctor
    else
        render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.permit(:specialization, :clinic_address, :clinic_name, :clinic_phone_number, :available_time_date, :end_of_duty, :user_id)
  end
end
