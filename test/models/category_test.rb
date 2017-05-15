require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category=Category.new(name: "sports")
  end
  
  #below tests ensure code allows creation of category, doesn't allow empty or duplicate name. Test is on the CODE not on the INPUTS. 
  
  test "row entry in category table can get created and is valid" do
    assert @category.valid?
  end
  
  test "row entry in category table must have a name" do
    @category.name=""
    assert_not @category.valid?
  end
  
  test "row entry in category table should have unique name" do
    @category.save
    @category2=Category.new(name: "sports")
    assert_not @category2.valid?
  end

end