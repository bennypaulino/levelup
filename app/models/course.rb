class Course < ActiveRecord::Base
  belongs_to :user
  has_many :sections
  has_many :enrollments

  validates :title, :presence => { :message => "A title for the class might be helpful :.)" }
  validates :description, :presence => { :message => "Add a description for your awesome, new course :.)" }
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}

  mount_uploader :image, ImageUploader
end