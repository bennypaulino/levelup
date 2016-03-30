class Course < ActiveRecord::Base
  belongs_to :user

  validates :title, :presence => { :message => "A title for the class might be helpful :.)" }
  validates :description, :presence => { :message => "Add a description for your awesome, new course :.)" }
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
end
