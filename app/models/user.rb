class User < ActiveRecord::Base
  has_many :offers
  has_many :projects_offered, through: :offers, source: :project

  has_and_belongs_to_many :technologies

  validates :name, :nickname, :city, :country, :tel, :web, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9]( ?[a-zA-Z0-9.-])+\z/ }
  validates :nickname, format: { with: /\A[a-zA-Z\d_]{1,14}\z/ }, uniqueness: true
  validates :city, :country, format: { with: /\A[a-zA-Z]( ?[a-zA-Z])+\z/ }
  validates :tel, format: { with: /\A[24][0-9]{7}\z/ }
  validates :web, format: { with: /\A(www[.])?[a-zA-Z\d-]+([.][a-zA-Z]{2,})+\z/ }

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  private

  def uploaded_projects
    projects = Project.where("owner_id = ? AND deadline >= ?", self.id, Date.today)
    projects.map { |project| ProjectSerializer.new(project) }
  end

  def projects_as_candidate
    offers = Offer.joins(:project).where("projects.developer_id = ? OR (projects.developer_id IS NULL AND projects.deadline >= ? AND offers.user_id = ?)", self.id, Date.today, self.id)
    offers.map { |offer| ProjectSerializer.new(offer.project) }
  end

  def projects_done
    project = Project.where(developer_id: self.id, state: 'finished')
    project.map { |project| ProjectSerializer.new(project) }
  end

  def developer_score
    score = 0
    projects = Project.where("developer_id = ? AND state = ? AND developer_score IS NOT NULL", self.id, 'finished')
    projects.each { |project|
      score += project.developer_score
    }
    projects.count == 0 ? score : score / projects.count
  end

  def owner_score
    score = 0
    projects = Project.where("owner_id = ? AND state = ? AND owner_score IS NOT NULL", self.id, 'finished')
    projects.each { |project|
      score += project.owner_score
    }
    projects.count == 0 ? score : score / projects.count
  end
end
