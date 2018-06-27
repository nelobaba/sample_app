require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  #says “Let’s test the Home page by issuing a GET request to the Static Pages home URL 
  #and then making sure we receive a ‘success’ status code in response.”
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # test "should get root" do
  #   get FILL_IN
  #   assert_response FILL_IN
  # end

  test "should get home" do
    get static_pages_home_url #get a url, Home and Help pages are ordinary urls accessed via GET request. 
    assert_response :success #The abstract representation of of the underlying HTTP status code ie 200
    #the code above checks for the presence of a <title> tag containing the string “Home | Ruby on Rails Tutorial Sample App”
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

end
