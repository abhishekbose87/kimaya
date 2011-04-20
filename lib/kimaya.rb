require 'active_support'
require 'active_model'
require  File.dirname(__FILE__) + '/kimaya/kimaya_core.rb'
require  File.dirname(__FILE__) + '/kimaya/kimaya.rb'
I18n.load_path = Dir[(File.dirname(__FILE__) + '/config/locales/*.yml').to_s]
I18n.default_locale = :en
