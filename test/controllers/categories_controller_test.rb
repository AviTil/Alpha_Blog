require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category=Category.new(name: "sports")
    @category.save
  end
  
  test "can get categories index" do
    get :index
    assert_response :success
  end
  
  test "can add new category" do
    get :new
    assert_response :success
  end
  
  test "can show a category" do
    get( :show, { 'id' => @category.id })
    assert_response :success
  end

end