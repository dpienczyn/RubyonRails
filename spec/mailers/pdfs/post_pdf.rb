class PostPdf < Prawn::Document

	def initialize(post)
	  super :page_size => "A4", :page_layout => :landscape
	  font Rails.root.join("app/assets/fonts/Merriweather/Merriweather-Regular.ttf")
	  @post = post
		text "Tytuł: #{@post.title} "
		text "Opis: #{@post.description}"
	end
	# def post_description
	# 	text "Opis: #{@post.title} "
	# 	text "Description: #{@post.description}"
	# end
end
