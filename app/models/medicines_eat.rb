class MedicinesEat < ApplicationRecord
    belongs_to :medicine
    belongs_to :patient
end
