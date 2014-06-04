ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rails/all'
require 'cms-fortress'
require 'minitest/pride'

# require 'minitest/unit'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'minitest/spec'
# require 'minitest/rails'

# test without creating a test database.
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

load File.dirname(__FILE__) + '/schema.rb'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end
