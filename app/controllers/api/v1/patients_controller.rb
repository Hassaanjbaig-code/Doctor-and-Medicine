class Api::V1::PatientsController < ApplicationController
  def index
    @patients = Patient.all
    render json: @patients.as_json(only: [:symptoms, :age, :doctor_id], methods: [:patient_name]), status: :ok
  end

  def show
    @patient = Patient.find(params[:id])
    render json: @patient.as_json(only: [:symptoms, :age, :doctor_id, :user_id], methods: [:patient_name])
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: @patient, status: :created
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      render json: @patient, status: :created, location: @patient
    else
        render json: @patient.errors, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.permit(:symptoms, :age, :user_id, :doctor_id)
  end
end
