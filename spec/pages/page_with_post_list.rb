module PageWithPostList
	include Gizmo::PageMixin

	def valid?
		has_css?('.parent #posts')
	end

	def post_page_title
		find("#posts").find('h1').text
	end

	def posts_list
		find("#posts").find("table#posts_list").find("tbody").all("tr")
	end

	def latest_post_title
		posts_list.first.find("td:nth-child(1)").text
	end

	def latest_post_content
		posts_list.first.find("td:nth-child(2)").text
	end

	def new_post_link
		find("#posts").find("a#new_post")
	end

	define_action :new_post do 
		new_post_link.click
  end

end