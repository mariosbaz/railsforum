require 'spec_helper'
 
describe TopicsController do   
  describe 'authenticated users' do 
    before :each do
      @user = create(:user)
      sign_in @user
      @topic = create(:topic, name: 'test', user: @user)   
    end 

    describe 'GET #show' do
    	it "assigns the requested topic to @topic" do
    	  get :show, id: @topic
    	  expect(assigns(:topic)).to eq @topic
    	end

      it "assigns the @topic posts to @posts" do
        post = create(:post, topic: @topic)
        posts = @topic.posts.to_a
        get :show, id: @topic
        expect(assigns(:posts)).to eq posts
      end

    	it "renders the :show template" do
    	  get :show, id: @topic
    	  expect(response).to render_template :show
    	end
    end

    describe 'GET #index' do 
      it "populates an array of all topics" do
        topic1 = create(:topic)
        topic2 = create(:topic)
        get :index
        expect(assigns(:topics)).to match_array([topic1, topic2, @topic])
      end

      it "populates two arrays of newest and oldest topics" do
        (0..10).each { create(:topic) } 
        newtopics = Topic.all(order: "created_at DESC", limit: 5)
        oldtopics = Topic.all(order: "created_at ASC", limit: 5)
        get :index
        expect(assigns(:newtopics)).to eq newtopics
        expect(assigns(:oldtopics)).to eq oldtopics
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index      
      end
    end

    describe 'GET #new' do
      it "assigns a new Topic to @topic" do
    	  get :new
        expect(assigns(:topic)).to be_a_new(Topic)
  	  end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do    
      it "assigns the requested topic to @topic" do
        get :edit, id: @topic
        expect(assigns(:topic)).to eq @topic
      end

      it "renders the :edit template" do
        get :edit, id: @topic
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new topic in the database" do
          expect{ 
            post :create, topic: attributes_for(:topic) 
            }.to change(Topic, :count).by(1)
        end

        it "redirects to topics#show" do
          post :create, topic: attributes_for(:topic)
          expect(response).to redirect_to topic_path(assigns[:topic])
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new topic in the database" do
          expect{
           post :create, topic: attributes_for(:invalid_topic)
           }.not_to change(Topic, :count)
        end

        it "re-renders the :new template" do
          post :create, topic: attributes_for(:invalid_topic)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context "valid attributes" do
        it "locates the requested @topic" do
          patch :update, id: @topic, topic: attributes_for(:topic)
          expect(assigns(:topic)).to eq(@topic)
        end

        it "changes @topic's attributes" do
          patch :update, id: @topic, topic: attributes_for(:topic,
            name: 'valid test', user: @user)
          @topic.reload
          expect(@topic.name).to eq('valid test')
          expect(@topic.name).not_to eq('test')
        end

        it "redirects to the updated contact" do
          patch :update, id: @topic, topic: attributes_for(:topic)
          expect(response).to redirect_to @topic
          end
        end

      context "invalid attributes" do
        it 'does not change the @topics attributes' do
          patch :update, id: @topic, topic: attributes_for(:invalid_topic, 
            user: @user) 
          @topic.reload
          expect(@topic.name).to eq('test')
        end

        it "re-renders to the :edit template" do 
          patch :update, id: @topic, topic: attributes_for(:invalid_topic, 
            user: @user)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do    
      context 'with valid attributes' do
        it "deletes the topic" do
          expect{ delete :destroy, id: @topic
            }.to change(Topic,:count).by(-1)
        end

        it "redirects to topics#index" do
          delete :destroy, id: @topic
          expect(response).to redirect_to topics_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          @user1 = create(:user)
          @user2 = create(:user)
          sign_in @user1
          @topic2 = create(:topic, name: 'test2', user: @user2)   
        end 

        it "does not delete the topic" do
          expect{ delete :destroy, id: @topic2
            }.to_not change(Topic,:count)
        end

        it "redirects to topics#index" do
          delete :destroy, id: @topic
          expect(response).to redirect_to topics_url
        end
      end
    end
  end

  describe 'guests' do    
    # GET #index and GET #show examples are the same as for authenticated users
    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        topic = create(:topic)
        get :edit, id: topic
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:topic),
          topic: attributes_for(:topic)
        expect(response).to redirect_to new_user_session_url
        end
      end
    
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:topic),
          topic: attributes_for(:topic)
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:topic)
        expect(response).to redirect_to new_user_session_url
      end
    end   
  end
end 