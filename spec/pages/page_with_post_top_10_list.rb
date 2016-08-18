module PageWithPostTop10List
  include Gizmo::PageMixin

  def valid?
    has_css?('.parent #top_10_posts')
  end

  def post_top_10_page_title
    find("#top_10_posts").find('h1').text
  end

  def top_10_posts_list
    find("#top_10_posts").find("#top_10_container").find("#top_10_list").all("li")
  end

  def top_1_post_title
    top_10_posts_list.first.text
  end

end