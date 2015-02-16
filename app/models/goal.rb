class Goal < ActiveRecord::Base
  validates :user, :title, presence: true
  validates :public,
    inclusion: {in: [false, true], message: "Must be public or private"}

  belongs_to :user

  def self.public_goals(excluded_user)
    Goal.where('goals.user_id <> ?', excluded_user.id).where(public: true)
  end
end
