require 'test_helper'

describe 'Edit existing works on page' do
  before do
    sign_in
    click_on 'New work'
    fill_in 'Title', with: 'Testing the works'
    fill_in 'Body', with: 'The body of the test work'
    click_on 'Create Work'
  end

  it 'should let the owner edit his/her work' do
    visit edit_work_path(1)

    fill_in 'Title', with: 'Editing the works'
    fill_in 'Body', with: 'Editing the body of the test work'
    click_on 'Update Work'

    page.text.must_include 'successfully updated'
  end

  it 'should let others edit works and add new attributions' do
    sign_out
    sign_in :user_2
    visit edit_work_path(1)

    fill_in 'Title', with: 'Editing other works'
    fill_in 'Body', with: 'Editing the body of other work'
    click_on 'Update Work'

    page.text.must_include 'successfully updated'
    page.text.must_include users(:user_1).username
    page.text.must_include users(:user_2).username
  end
end
