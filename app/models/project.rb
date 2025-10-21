class Project < ApplicationRecord
    has_many :entries, dependent: :destroy


    def totalHours
    entries.sum(:hours)
  end
end

