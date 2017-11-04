class User < ActiveRecord::Base
  has_many :offers
  has_many :projects_offered, through: :offers, source: :project

  validates :name, :nickname, :city, :country, :tel, :web, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9]( ?[a-zA-Z0-9.-])+\z/ }
  validates :nickname, format: { with: /\A[a-zA-Z\d_]{1,14}\z/ }, uniqueness: true
  validates :city, :country, format: { with: /\A[a-zA-Z]( ?[a-zA-Z])+\z/ }
  validates :tel, format: { with: /\A[24][0-9]{7}\z/ }
  validates :web, format: { with: /\A(www[.])?[a-zA-Z\d-]+([.][a-zA-Z]{2,})+\z/ }

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
          #:confirmable

  include DeviseTokenAuth::Concerns::User

  private

  def uploaded_projects
    projects = Project.where(owner_id: self.id)
    projects.map { |project| ProjectSerializer.new(project) }
  end

  def developer_score
    score = 0
    projects = Project.where(developer_id: self.id)
    projects.each { |project|
      score += project.developer_score unless project.developer_score.nil?
    }
    score
  end

  def owner_score
    score = 0
    projects = Project.where(owner_id: self.id)
    projects.each { |project|
      score += project.owner_score unless project.owner_score.nil?
    }
    score
  end
end
