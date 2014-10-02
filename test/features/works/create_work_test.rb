require 'test_helper'

describe 'Create work on root page' do
  it 'should not let unsigned users create works' do
    visit new_work_path

    page.text.must_include 'You need to sign in'
  end

  it 'should let signed in users create works with attribution' do
    sign_in
    visit new_work_path

    fill_in 'Title', with: 'YAY'
    fill_in 'Body', with: 'Woopdidoo'
    click_on 'Create Work'

    page.text.must_include 'successfully created'
    page.text.must_include users(:user_1).username
  end
end
