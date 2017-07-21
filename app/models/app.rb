class App < ApplicationRecord
  belongs_to :user
  has_many :shortcuts, dependent: :destroy
  enum app_type: { shortcuts: 0, commands: 1 }

  has_attached_file :image, :styles => { :medium => "1000x600#" }, :preserve_files => "false"
  validates_attachment :image, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, presence: true
  validates :app_type, presence: true
  validate :app_type_not_changed


  def app_type_not_changed
    if app_type_changed? && self.persisted?
      errors.add(:app_type, "Change of app_type is not allowed!")
    end
  end

  def image_url
    image.url(:medium)
  end
end
