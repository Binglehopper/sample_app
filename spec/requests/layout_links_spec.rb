require 'spec_helper'

describe "LayoutLinks" do

	it "should have a Home Page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end

	it "should have a Contage page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact") 
	end

end
