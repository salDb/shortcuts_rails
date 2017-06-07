class App < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image

  validates :name, presence: true

end
