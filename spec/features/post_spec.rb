require 'rails_helper'

RSpec.feature 'post feature', type: :feature do
  scenario 'create post' do
    view_posts

    before_create_post_list

    create_post

    show_post

    after_create_post_list
  end

  def view_posts
    visit '/posts'
  end

  def before_create_post_list
    on_page_with(:post_list, :post_top_10_list) do |page|

      load_top10_posts

      expect(page.post_page_title).to eq("Posts")
      expect(page.posts_list.length).to eq(0)

      
      expect(page.post_top_10_page_title).to eq("TOP 10 Posts")
      expect(page).not_to have_css("#top_10_list")

      page.perform :new_post

    end
  end

  def create_post
    on_page_with :post_create do |page|
      expect(page.new_page_title).to eq('New Post')
    
      title = 'capybara'
      post_content = <<-eos
          Capybara helps you test web applications by simulating
          how a real user would interact with your app. 
          It is agnostic about the driver running your 
          tests and comes with Rack::Test and Selenium support built in.
          WebKit is supported through an external gem.
      eos
      
      page.perform :create_post, title, post_content
    end
  end

  def show_post
    on_page_with :post_show do |page|
      expect(page.notice_message).to eq("Post was successfully created.")
      page.perform :back_to_posts_list
    end
  end

  def after_create_post_list
    on_page_with(:post_list, :post_top_10_list) do |page|

      load_top10_posts

      expect(page.posts_list.length).to eq(1)
      expect(page.latest_post_title).to eq("capybara")
      expect(page.latest_post_content).to have_content("WebKit is supported through an external gem")


      expect(page.top_10_posts_list.length).to eq(1)
      expect(page.top_1_post_title).to eq("capybara")
    end
  end

  def load_top10_posts
    expect(page).to have_content('TOP 10 Posts')
    expect(page).to have_content('initialize component')
    expect(page).not_to have_content('start loading...')
  end

end
