class Command < ApplicationRecord
    belongs_to :app
    validates :command_description, presence: true, length: {minimum: 3}
    validates :command, presence: true
end
