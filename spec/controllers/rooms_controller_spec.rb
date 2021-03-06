require 'rails_helper'
RSpec.describe RoomsController, :type => :controller do
  before { session[:user_id] = current_user_id }

  let(:user_attributes)    { FactoryGirl.attributes_for(:user) }
  let(:current_user_id)    { User.create(user_attributes).id }
  let(:valid_attributes)   { FactoryGirl.attributes_for(:room) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:room, description: nil) }

  let(:valid_session)      { {} }

  describe "GET index" do
    it "assigns all rooms as @rooms" do
      room = Room.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:rooms)).to eq([room])
    end
  end

  describe "GET show" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes
      get :show, {:id => room.to_param}, valid_session
      expect(assigns(:room)).to eq(room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      get :new, {}, valid_session
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe "GET edit" do
    it "assigns the requested room as @room" do
      room = Room.create! valid_attributes
      get :edit, {:id => room.to_param}, valid_session
      expect(assigns(:room)).to eq(room)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Room" do
        expect {
          post :create, {:room => valid_attributes}, valid_session
        }.to change(Room, :count).by(1)
      end

      it "assigns a newly created room as @room" do
        post :create, {:room => valid_attributes}, valid_session
        expect(assigns(:room)).to be_a(Room)
        expect(assigns(:room)).to be_persisted
      end

      it "redirects to the created room" do
        post :create, {:room => valid_attributes}, valid_session
        expect(response).to redirect_to(Room.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        post :create, {:room => invalid_attributes}, valid_session
        expect(assigns(:room)).to be_a_new(Room)
      end

      it "re-renders the 'new' template" do
        post :create, {:room => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { FactoryGirl.attributes_for(:room, description: 'new description') }

      it "updates the requested room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => new_attributes}, valid_session
        room.reload
        expect(room.description).to eq "new description"
      end

      it "assigns the requested room as @room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => valid_attributes}, valid_session
        expect(assigns(:room)).to eq(room)
      end

      it "redirects to the room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => valid_attributes}, valid_session
        expect(response).to redirect_to(room)
      end
    end

    describe "with invalid params" do
      it "assigns the room as @room" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => invalid_attributes}, valid_session
        expect(assigns(:room)).to eq(room)
      end

      it "re-renders the 'edit' template" do
        room = Room.create! valid_attributes
        put :update, {:id => room.to_param, :room => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested room" do
      room = Room.create! valid_attributes
      expect {
        delete :destroy, {:id => room.to_param}, valid_session
      }.to change(Room, :count).by(-1)
    end

    it "redirects to the rooms list" do
      room = Room.create! valid_attributes
      delete :destroy, {:id => room.to_param}, valid_session
      expect(response).to redirect_to(rooms_url)
    end
  end
end
