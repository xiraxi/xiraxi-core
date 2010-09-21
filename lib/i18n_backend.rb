class XiraxiCore::I18nBackend < I18n::Backend::Simple

  def lookup(locale, key, scope = [], options = {})
    unless scope.blank?
      scope = scope.join(".") if scope.kind_of?(Array)
      key = [scope, key].join(".")
    end

    result = Translation.get(key, locale) || super(locale, key, [], options)  || super(I18n.default_locale, key, [], options)

    if result.kind_of?(Hash)
      result.each_key do |result_key|
        if t = lookup(locale, "#{key}.#{result_key}")
          result = result.merge(result_key => t)
        end
      end
    end

    result
  end

  def user_keys
    items = []
    user_keys_walk I18n.t("", :locale => I18n.default_locale), "", items
    items.sort!
  end

  private

  def user_keys_walk(hash, prefix, items)
    hash.each_pair do |key, value|
      case value
      when String
        items << "#{prefix}#{key}"
      when Hash
        user_keys_walk value, "#{prefix}#{key}.", items
      end
    end
  end

end

