class Pokemon < ActiveRecord::Base
	validates :name, presence: true # Validates that there is a name
	belongs_to :trainer
end
