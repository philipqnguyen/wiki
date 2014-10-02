ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require 'minitest/rails/capybara'

# Uncomment for awesome colorful output
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in(test_user = :user_1)
    visit new_user_session_path
    fill_in 'Email', with: users(test_user).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def sign_out
    click_on 'Sign out'
  end

  def create_work(title = 'Auto')
    click_on 'New work'
    fill_in 'Title', with: title
    fill_in 'Body', with: 'The body of the test work'
    click_on 'Create Work'
  end

  def edit_work(id)
    visit edit_work_path id
    fill_in 'Body', with: 'Trolled!'
    click_on 'Update Work'
  end
end

# Spec class for spec/features/**
class FeatureSpec < Capybara::Rails::TestCase
  include Capybara::DSL
  Capybara.default_driver = :rack_test
  # Capybara.javascript_driver = :poltergeist
  register_spec_type(/page$/, self)
end
