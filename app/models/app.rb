class App < ApplicationRecord
  belongs_to :user

  has_attached_file :image
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image
  validates :name, presence: true
end
