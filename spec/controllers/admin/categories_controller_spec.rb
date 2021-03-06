require 'spec_helper'

describe Admin::CategoriesController do
  render_views
  describe "test admin actions for non-admin" do
    before :each do
      Factory(:blog)
      Profile.delete_all
      @henri = Factory(:user, :login => 'henri')
    end
    it "should redirect to the login page if user is not logged in when going to the categories page" do
      request.session = {}
      get :index
      response.should redirect_to "/accounts/login"
    end
    it "should redirect to the login page if the user is not an admin when going to the categories page" do
      request.session = { :user => @henri.id }
      get :index
      response.should redirect_to "/accounts/login"
    end
  end

  describe "test admin actions for admin" do
    before(:each) do
      Factory(:blog)
      #TODO Delete after removing fixtures
      Profile.delete_all
      henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      request.session = { :user => henri.id }
    end

    describe "test_index" do
      it "should redirect to new" do
        get :index
        assert_response :redirect, :action => 'new'
      end
    end

    describe "create new category page" do
      it 'should render template new' do
        get :new
        response.should have_rendered("new")
        assert_tag :tag => "form"
      end
    end

    describe "creating a new category" do
      before :each do
        @fake_input = { "name" => 'test', "permalink" => 'test_link' }
        @fake_result = double(@fake_input)
      end
      it "should call the category method to create a new category" do
        Category.should_receive(:new).with(@fake_input).and_return(@fake_result)
        @fake_result.should_receive(:save!)
        post :edit, {:category => @fake_input}
      end
    end

    describe "test_edit" do
      before(:each) do
        get :edit, :id => Factory(:category).id
      end

      it 'should render template new' do
        assert_template 'new'
        assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
      end

      it 'should have valid category' do
        assigns(:category).should_not be_nil
        assert assigns(:category).valid?
        assigns(:categories).should_not be_nil
      end
    end

    it "test_update" do
      post :edit, :id => Factory(:category).id
      assert_response :redirect, :action => 'index'
    end

    describe "test_destroy with GET" do
      before(:each) do
        test_id = Factory(:category).id
        assert_not_nil Category.find(test_id)
        get :destroy, :id => test_id
      end

      it 'should render destroy template' do
        assert_response :success
        assert_template 'destroy'      
      end
    end

    it "test_destroy with POST" do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id

      post :destroy, :id => test_id
      assert_response :redirect, :action => 'index'

      assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
    end

  end
end
