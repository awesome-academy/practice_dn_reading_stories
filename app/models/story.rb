class Story < ApplicationRecord
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

end
