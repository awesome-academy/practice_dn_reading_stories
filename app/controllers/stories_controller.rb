class StoriesController < ApplicationController
  before_action :load_story

  def index;  end

  def show
    @chapters = @story.chapters.order_chapter.paginate(page: params[:page])
  end
end
