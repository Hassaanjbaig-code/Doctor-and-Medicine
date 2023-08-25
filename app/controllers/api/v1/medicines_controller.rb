class Api::V1::MedicinesController < ApplicationController
  before_action :authenticate_request
  before_action :current_user
  def index
    medicines = Medicine.all.with_attached_image
      medicine_with_image = medicines.map do |medicine|
        medicine_hash = {
          id: medicine.id,
          name: medicine.name,
          milligrams: medicine.milligrams,
          dose: medicine.dose,
          time_to_take: medicine.time_to_take,
          doctor_id: medicine.doctor_id,
          patient_id: medicine.patient_id
        }
        medicine_hash[:image_url] = url_for(medicine.image) if medicine.image.attached?
        medicine_hash
    end
    render json: medicine_with_image
  end

  def patient_medicines
    medicines = Medicine.where(patient_id: params[:id]).with_attached_image
    medicine_with_image = medicines.map do |medicine|
      medicine_hash = {
        id: medicine.id,
        name: medicine.name,
        milligrams: medicine.milligrams,
        dose: medicine.dose,
        time_to_take: medicine.time_to_take,
        doctor_id: medicine.doctor_id,
        created_at: medicine.created_at
      }
      medicine_hash[:image_url] = url_for(medicine.image) if medicine.image.attached?
      medicine_hash
    end
    render json: medicine_with_image
  end

  def create
    medicine = Medicine.new(medicine_params)
    if medicine.save!
      render json: { message: 'Medicine is created' }, status: :created
    else
      render json: medicine.errors, status: :unprocessable_entity
    end
  end

  def edit
    medicine = Medicine.find(params[:id])
    if medicine.update(medicine_params)
      render json: medicine, status: :created
    else
        render json: medicine.errors, status: :unprocessable_entity
    end
  end

  def destroy
    medicine = Medicine.find(params[:id])
    if medicine.destroy!
      render json: { message: "Successfully deleted" }
    else
      render json: medicine.errors, status: :unprocessable_entity, notice: "Failed to delete"
    end
  end

  private

  def medicine_params
    params.permit(:name, :milligrams, :dose, :time_to_take, :doctor_id, :patient_id, :image)
  end
end
