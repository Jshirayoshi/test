require 'test_helper'

class SyukeisControllerTest < ActionDispatch::IntegrationTest
  test "should get office" do
    get syukeis_office_url
    assert_response :success
  end

  test "should get calc" do
    get syukeis_calc_url
    assert_response :success
  end

end
