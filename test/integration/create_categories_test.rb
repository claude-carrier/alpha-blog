require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  
  test "get new category form and create category" do
    # can't use session[:user_id] = @user.id
    sign_in_as(@user, "password") #sign_in_as is defined in test_helper.rb
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    # See /alpha-blog/app/views/shared/_errors.html.erb for where the following
    #   tags/classes are defined
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
end