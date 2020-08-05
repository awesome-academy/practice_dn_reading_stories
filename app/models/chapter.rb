class Chapter < ApplicationRecord

  belongs_to :story

  validates :chapter_name, presence: true
  validates :chapter_number, presence: true
  validates :content, presence: true

  delegate :story_name, :views, to: :story, prefix: true

  scope :order_chapter, -> {order chapter_number: :desc}
  scope :lastest_chapter, -> {maximum("chapter_number")}

  def next_chapter
    story.chapters.find_by(chapter_number: self.chapter_number + 1)
  end

  def previous_chapter
    story.chapters.find_by(chapter_number: self.chapter_number - 1)
  end

end
