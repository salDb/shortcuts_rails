class App < ApplicationRecord
  belongs_to :user
  has_many :shortcuts, dependent: :destroy

  has_attached_file :image, :styles => { :medium => "1000x600#" }
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image
  validates :name, presence: true

  def image_url
    image.url(:medium)
  end
end
