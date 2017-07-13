class Shortcut < ApplicationRecord
  belongs_to :app

  validates :action_name, presence: true, length: {minimum: 3}, uniqueness: true
  validates :first_action, presence: true
  validates :second_action, presence: true
end
