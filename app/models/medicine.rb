class Medicine < ApplicationRecord
    belongs_to :patient
    has_one :doctor, through: :patient
    has_many :medicines_eats

    has_one_attached :image

end
