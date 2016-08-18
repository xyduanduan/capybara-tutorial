module PageWithPostShow
  include Gizmo::PageMixin

  def valid?
    has_css?('#notice')
  end

  def notice_message
    find("#notice").text
  end

  def back_link
    find("#back_to_posts")
  end

  define_action :back_to_posts_list do 
    back_link.click
  end

end