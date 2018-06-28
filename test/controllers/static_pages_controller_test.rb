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
    get root_path    #get a url, Home and Help pages are ordinary urls accessed via GET request. 
    assert_response :success #The abstract representation of of the underlying HTTP status code ie 200
    #the code above checks for the presence of a <title> tag containing the string “Home | Ruby on Rails Tutorial Sample App”
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end

end
