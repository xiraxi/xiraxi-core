Rails.application.class.routes.draw do

  match 'settings/locale/:locale' => 'locales#set_locale', :as => "set_locale"

end
