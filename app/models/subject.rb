class Subject < ApplicationRecord

	#Associations
	has_many :pages

	#Constructor scopes	
	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order(:position => :asc) }
	scope :newest_first, lambda { order(:created_at => :desc) }
	scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}

	#Validations
	validates_presence_of :name
	validates_length_of :name, :maximum => 255

end
