class Translation < ActiveRecord::Base

  def self.get(key, locale = I18n.locale)
    if f = first(:conditions => ['key = ? AND locale = ?', key, locale.to_s])
      f.text
    end
  end

  def self.keys_from_locale(locale)
    all(:select => "key", :conditions => ['locale = ?', locale.to_s]).map {|record| record.key }
  end

  validates_presence_of :key, :locale, :text
  validate :_check_vars
  def _check_vars
    placeholder_regex = /(\{\{\w+\}\})|(%\{\w+\})/

    original_keys = I18n.backend.lookup(I18n.default_locale, key).scan(placeholder_regex).sort
    new_keys = text.scan(placeholder_regex).sort

    if new_keys != original_keys
      errors.add :text, "Some variables was not found"
    end
  end


end
