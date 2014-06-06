ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rails/all'
require 'cms-fortress'
require 'minitest/pride'
require 'minitest/reporters'

# test without creating a test database.
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

MiniTest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

load File.dirname(__FILE__) + '/../db/schema.rb'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end
