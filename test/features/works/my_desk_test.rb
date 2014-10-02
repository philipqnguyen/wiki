require 'test_helper'

describe 'My desk page' do
  before do
    sign_in
    create_work 'Charizard'
    sign_out

    sign_in :user_2
    create_work 'Pikachu'
    visit root_path
    create_work 'Squirtle'
    sign_out
  end

  it 'should show the works a user has been involved in' do
    sign_in
    edit_work 2
    edit_work 3

    visit my_desk_path

    page.text.must_include 'Charizard'
    page.text.must_include 'Pikachu'
    page.text.must_include 'Squirtle'
  end
end
