class LocalesController < ApplicationController

  def set_locale
    locale = params[:locale].to_s
    if I18n.available_locales.map {|l| l.to_s }.include?(locale)
      session[:current_locale] = locale
    end

    redirect_to(params[:return] || :back)
  end

end
