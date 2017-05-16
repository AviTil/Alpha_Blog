require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category=Category.new(name: "sports")
    @category.save
    @user=User.create(username: "sally", email: "sally@gmail.com", password: "sally123", admin: true)
  end
  
  test "can get categories index" do
    get :index
    assert_response :success
  end
  
  test "admin user can add new category" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
    
  end
  
  test "can show a category" do
    get( :show, { 'id' => @category.id })
    assert_response :success
  end
  
  test "user unable to create category when not signed in as admin" do
    assert_difference 'Category.count', 0 do
    post :create, category: {name: "sports"} end
    assert_redirected_to categories_path
  end

end