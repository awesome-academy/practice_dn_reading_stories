class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
                  locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_story
    @story = Story.find_by id: params[:id]
    return if @story
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_chapter
    @chapter = Chapter.find_by id: params[:id]
    return if @chapter
    flash[:danger] = t ".danger"
    redirect_to stories_path
  end
end
