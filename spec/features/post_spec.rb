require 'rails_helper'

RSpec.feature 'post feature', type: :feature do
  scenario 'create, update and delete post' do
    create_post
    sleep(5)
    update_post
    sleep(5)
    delete_post
  end

  def create_post
    view_posts
    click_link('New Post')
    title = 'capybara'
    post_content = <<-eos
        Capybara helps you test web applications by simulating
        how a real user would interact with your app. 
        It is agnostic about the driver running your 
        tests and comes with Rack::Test and Selenium support built in.
        WebKit is supported through an external gem.
    eos
    fill_post(title, post_content)
    click_button('Create Post')
    expect(page).to have_content('Post was successfully created.')
    check_post_exist(title)
  end

  def update_post
    click_link('Edit')
    title = 'update my capybara'
    post_content = <<-eos
      If you are using Rails,
      put your Capybara specs in spec/features
      (only works if you have it configured in RSpec)
      and if you have your Capybara specs in a different directory,
      then tag the example groups with :type => :feature.
    eos
    fill_post(title, post_content)
    click_button('Update Post')
    expect(page).to have_content('Post was successfully updated.')
    check_post_exist(title)
  end

  def delete_post
    click_link('Destroy')
    page.driver.browser.switch_to.alert.accept
    check_post_unexist(title)
  end

  def fill_post(title, post_content)
    fill_in('post_title', with: title)
    fill_in('post_content', with: post_content)
  end

  def check_post_exist(title)
    load_top10_posts
    expect(page).to have_content(title)
  end

  def check_post_unexist(title)
    load_top10_posts
    expect(page).not_to have_content(title)
  end

  def load_top10_posts
    view_posts
    expect(page).to have_content('TOP 10 Posts')
    expect(page).to have_content('initialize component')
    expect(page).not_to have_content('finish loading')
  end

  def view_posts
    visit '/posts'
  end
end
