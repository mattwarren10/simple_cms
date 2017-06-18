class Page < ApplicationRecord

	acts_as_list :scope => :subject

	#Associations
	belongs_to :subject, { :optional => false }
	has_many :sections
	has_and_belongs_to_many :admin_users

	#Constructor scopes
	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order(:position => :asc) }
	scope :newest_first, lambda { order(:created_at => :desc) }
	scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}

	#Validations
	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	validates_uniqueness_of :permalink
	
end
