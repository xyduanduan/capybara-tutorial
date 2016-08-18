module PageWithPostUpdate
  include PageWithPostForm
  include Gizmo::PageMixin

  def valid?
    has_selector?("div#post_new")
  end

  def page_title
    find("h1")
  end

  def back_link
    find("a#back_to_posts")
  end

  def show_link
    find("a#show_post")
  end

  define_action :update_post do |title, content|
    fill_post title, content
  end

  define_action :back_to_posts_list do 
    back_link.click
  end

  define_action :show_post do 
    show_link.click
  end
end