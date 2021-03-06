require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user=User.create(username: "sally", email: "sally@gmail.com", password: "sally123", admin: true)  
  end
  
  test "logged in admin can create a new category and display it" do
    sign_in_as(@user, "sally123")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"} end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category does not get submitted" do
    sign_in_as(@user, "sally123")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 0 do
      post categories_path, category: {name: ""} end
    assert_template 'categories/new'
  end
end