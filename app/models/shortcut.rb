class Shortcut < ApplicationRecord
  belongs_to :app
  before_save :upcase_shortcut

  validates :action_name, presence: true, length: {minimum: 3}
  validates :first_action, presence: true
  validates :second_action, presence: true

  def upcase_shortcut
    self.first_action.upcase!
    self.second_action.upcase!
    self.third_action.upcase! unless third_action.blank?
    self.fourth_action.upcase! unless fourth_action.blank?
  end
end

