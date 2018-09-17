require 'test_helper'

class ModalsControllerTest < ActionController::TestCase
  setup do
    @modal = modals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modal" do
    assert_difference('Modal.count') do
      post :create, modal: {  }
    end

    assert_redirected_to modal_path(assigns(:modal))
  end

  test "should show modal" do
    get :show, id: @modal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modal
    assert_response :success
  end

  test "should update modal" do
    patch :update, id: @modal, modal: {  }
    assert_redirected_to modal_path(assigns(:modal))
  end

  test "should destroy modal" do
    assert_difference('Modal.count', -1) do
      delete :destroy, id: @modal
    end

    assert_redirected_to modals_path
  end
end
