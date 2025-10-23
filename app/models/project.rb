class Project < ApplicationRecord
    belongs_to :user
    has_many :entries, dependent: :destroy


    def totalHours
    entries.sum(:hours)
  end
end

