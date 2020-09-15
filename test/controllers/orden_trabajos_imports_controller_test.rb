require 'test_helper'

class OrdenTrabajosImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get orden_trabajos_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get orden_trabajos_imports_create_url
    assert_response :success
  end

end
