class Goal < ActiveRecord::Base
  validates :user, :title, presence: true
  validates :public,
    inclusion: {in: [false, true], message: "Must be public or private"}

  belongs_to :user
end
