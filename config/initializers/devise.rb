require 'devise'

Devise.setup do |config|
  config.authentication_keys = [ :email ]
  config.router_name = :spree
  config.default_scope = :spree_user
end