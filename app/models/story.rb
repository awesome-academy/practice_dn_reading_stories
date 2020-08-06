class Story < ApplicationRecord
  ORDERS = %i(story_name views).freeze

  has_many :actions, dependent: :delete_all
  has_many :payment_histories, dependent: :delete_all
  has_many :chapters, dependent: :delete_all
  belongs_to :user
  belongs_to :category

  scope :order_by_views, -> { order(views: :DESC)}
  scope :search_by_name_or_author, ->(term){
    order(created_at: :DESC) if term.blank?
    where("story_name LIKE :search OR author LIKE :search", search: "%#{term}%") unless term.blank?
  }
  scope :order_by_created_at, -> {order(created_at: :DESC)}

  validates :story_name, presence: true, length: {maximum: Settings.NAME_MAXIMUM}
  validates :author, presence: true, length: {maximum: Settings.AUTHOR_MAXIMUM}

  scope :relative_intro, -> {includes(:chapters).includes(:category)}

  def new_chapter
    self.lastest_chapter + 1
  end

  def lastest_chapter
    chapters.lastest_chapter
  end
end
