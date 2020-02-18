class Event < ApplicationRecord
	belongs_to :user
	has_many :attendances
	has_many :users, through: :attendances

	validates :start_date, presence: true
	validates :duration, presence: true, numericality: { greater_than: 0}
	validates :title, presence: true, length: { in: 5..140 }
	validates :description, presence: true, length: { in: 20..1000 }
	validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
	validates :location, presence: true
	validate :start_date_cannot_be_in_the_past

	def start_date_cannot_be_in_the_past
		if !start_date.blank? && start_date < Date.today
      	errors.add(:start_date, "can't be in the past")
    	end
	end

	#def duration_must_be_multiple_of_5
	#	if (duration % 5) != 0
	#	errors.add(:duration, "must be a mutiple of 5")
	#	end
	#end
		
end
