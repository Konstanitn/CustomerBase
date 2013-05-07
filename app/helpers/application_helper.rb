module ApplicationHelper

	def full_title(title)
		basic_title = "CustomerBase"
		if title.empty?
			basic_title
		else
			"#{basic_title} > #{title}"
		end
	end

end
