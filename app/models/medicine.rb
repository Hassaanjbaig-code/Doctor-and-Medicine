class Medicine < ApplicationRecord
    belongs_to :patient
    has_one :doctor, through: :patient

    has_one_attached :image


    # def image_url
    #     images
    # end
end
