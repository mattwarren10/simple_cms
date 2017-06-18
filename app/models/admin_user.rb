class AdminUser < ApplicationRecord

	has_secure_password

	#Associations
	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	FORBIDDEN_USERNAMES = ['humptydumpty','marymary']
	
	# "sexy" validations
    validates :first_name, :presence => true,
						   :length => { :maximum => 25 }
    validates :last_name, :presence => true,
                          :length => { :maximum => 50 }
    validates :username, :length => { :within => 8..25 },
                         :uniqueness => true
    validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true
	validate :username_is_allowed

	scope :sorted, lambda { order(:last_name => :asc, :first_name => :desc)}
	

    def name
      "#{first_name} #{last_name}"
    end

	private

  	def username_is_allowed
    	if FORBIDDEN_USERNAMES.include?(username)
      	errors.add(:username, "has been restricted from use.")
    	end
  	end

  	

end
