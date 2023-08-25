class Api::V1::MedicinesEatsController < ApplicationController
    before_action :authenticate_request
    before_action :current_user

    def patient_medicines_eats
        medicines_eats = MedicinesEat.where(patient_id: params[:id])
        render json: medicines_eats
    end

    def create
        if current_user.patient? && current_user.patient.id == medicine_eat_params[:patient_id].to_i
        medicine_eat = MedicinesEat.new(medicine_eat_params)
        patient = Patient.find(medicine_eat_params[:patient_id])
        medicine_eat.patient_id = patient.id
        if medicine_eat.save!
            render json: { message: 'Medicine is Eated' }, status: :created
        else
            render json: medicine_eat.errors, status: :unprocessable_entity
        end
        else
            render json: { message: 'you are not a patient' }, status: :unprocessable_entity
        end
    end

    def edit
        medicine_eat = MedicinesEat.find(params[:id])
        if medicine_eat.update(medicine_eat_params)
            render json: medicine_eat, status: :created
        else
            render json: medicine_eat.errors, status: :unprocessable_entity
        end
    end

    private

    def medicine_eat_params
        params.require(:medicines_eat).permit(:eat, :medicine_id)
    end
end
