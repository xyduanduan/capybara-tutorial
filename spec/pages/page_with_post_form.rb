module PageWithPostForm 
  module ClassMethods
    def post_form
      element_struct do |form|
        form.title = find(".post_form").find("#post_title")
        form.content = find(".post_form").find("#post_content")
        form.submit = find(".post_form").find_button("submit")
      end
    end

    def fill_post title, content
      fill_in post_form.title, title
      fill_in post_form.content, content
      click post_form.submit
    end
  end

  extend ClassMethods
  def self.included( other )
    other.extend( ClassMethods )
  end
end


