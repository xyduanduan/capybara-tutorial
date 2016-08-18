module PageWithPostCreate
  include Gizmo::PageMixin

  def valid?
    has_css?('#post_new')
  end

  def new_page_title
    find("#post_new").find('h1').text
  end

  def post_form
    element_struct do |form|
      form.title = "post_title"
      form.content = "post_content"
    end
  end

  def fill_post title, content
    fill_in post_form.title, :with => title
    fill_in post_form.content, :with => content
  end

  def back_link
    find("#post_new").find("#back_to_posts")
  end

  define_action :create_post do |title, content|
    fill_post title, content
    click_button "Create Post"
  end

  define_action :back_to_posts_list do 
    back_link.click
  end

end