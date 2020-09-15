require 'test_helper'

class OrdenTrabajosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orden_trabajos_index_url
    assert_response :success
  end

  test "should get show" do
    get orden_trabajos_show_url
    assert_response :success
  end

  test "should get create" do
    get orden_trabajos_create_url
    assert_response :success
  end

  test "should get edit" do
    get orden_trabajos_edit_url
    assert_response :success
  end

  test "should get update" do
    get orden_trabajos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get orden_trabajos_destroy_url
    assert_response :success
  end

end
