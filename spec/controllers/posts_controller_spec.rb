require 'spec_helper'

describe PostsController do 
  describe 'authenticated users' do 
  	before :each do
      @user = create(:user)
      sign_in @user
      @topic = create(:topic, user: @user)   
      @post = create(:post, topic: @topic, user: @user)   
    end

    describe 'GET #show' do
      it "assigns requested  post to @post" do
        get :show, id: @post, topic_id: @topic.id
        expect(assigns(:post)).to eq @post
      end

      it "renders the :show template for the post" do
        get :show, id: @post, topic_id: @topic.id
        expect(response).to redirect_to topic_url(@topic)
      end
    end

    describe 'GET #index' do
      it "redirects to topic template" do
        get :index, topic_id: @topic.id
        expect(response).to redirect_to topic_url(@topic)
      end
    end

    describe 'GET #new' do
      it "assigns a new Post to @post" do
    	get :new, topic_id: @topic.id
        expect(assigns(:post)).to be_a_new(Post)
  	  end

  	   it "renders the :new template" do
        get :new, topic_id: @topic.id
        expect(response).to render_template :new
      end
    end
    
    describe 'GET #edit' do    
      it "assigns the requested post to @post" do
        get :edit, id: @post, topic_id: @topic.id
        expect(assigns(:post)).to eq @post
      end

      it "renders the :edit template" do
        get :edit, id: @post, topic_id: @topic.id
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do 
      context "with valid attributes" do
        it "saves the new post in the database" do
          expect{ 
            post :create, topic_id: @topic.id, 
              post: attributes_for(:post) 
            }.to change(Post, :count).by(1)
        end 

        it "renders the show template" do
          post :create, topic_id: @topic.id, 
            post: attributes_for(:post)
          expect(response).to render_template :show         
        end
      end

      context "with invalid attributes" do
        it "does not save the new post in the database" do
          expect{ 
            post :create, topic_id: @topic.id, 
              post: attributes_for(:invalid_post) 
            }.to_not change(Post, :count)
        end 

        it "renders the show template" do
          post :create, topic_id: @topic.id, 
            post: attributes_for(:invalid_post)
          expect(response).to render_template :show         
        end
      end
    end

    describe 'PATCH #update' do
      context "valid attributes" do
        it "locates the requested @post" do
          patch :update, id: @post, topic_id: @topic.id,
            post: attributes_for(:post)
          expect(assigns(:post)).to eq(@post)
        end

        it "changes @post's attributes" do
          patch :update, id: @post, topic_id: @topic.id,
            post: attributes_for(:post, content: 'valid content', 
            user: @user)
          @post.reload
          expect(@post.content).to eq('valid content')
        end

        it "redirects to the parent topic" do
          patch :update, id: @post, topic_id: @topic.id, 
            post: attributes_for(:post)
          expect(response).to redirect_to topic_post_url(@topic,@post)
          end
        end

      context "invalid attributes" do
      	before do 
         @post1 = create(:post, topic: @topic, user: @user, 
         	content: 'valid content')
      	end

        it 'does not change the @posts attributes' do
          patch :update, id: @post1, topic_id: @topic.id, 
            post: attributes_for(:invalid_post, user: @user) 
          @post1.reload
          expect(@post1.content).to eq('valid content')
        end

        it "re-renders to the :edit template" do 
          patch :update, id: @post1, topic_id: @topic.id,
            post: attributes_for(:invalid_post, user: @user)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
       context 'with valid attributes' do
        it "deletes the post" do
          expect{ delete :destroy, id: @post,
           topic_id: @topic.id
            }.to change(Post,:count).by(-1)
        end

        it "redirects to the parent topic" do
          delete :destroy, id: @post, topic_id: @topic.id
          expect(response).to redirect_to topic_url(@topic)
        end
      end

      context 'with invalid attributes' do
        before :each do
          @user1 = create(:user)
          @user2 = create(:user)
          sign_in @user1
          @post2 = create(:post, content: 'test content', topic: @topic, 
          	user: @user2)   
        end 

        it "does not delete the post" do
          expect{ delete :destroy, id: @post2, topic_id: @topic.id
            }.to_not change(Post, :count)
        end

        it "redirects to parent topic" do
          delete :destroy, id: @post, topic_id: @topic.id
          expect(response).to redirect_to topic_url(@topic)
        end
      end
    end
  end

  describe 'guests' do    
    # GET #index and GET #show examples are the same as for authenticated users
    before :each do 
      @topic = create(:topic)
      @post = create(:post, topic: @topic)
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, topic_id: @topic.id
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        get :edit, id: @post, topic_id: @topic.id
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, id: @post, topic_id: @topic.id, 
          post: attributes_for(:post)
        expect(response).to redirect_to new_user_session_url
        end
      end
    
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: @post, topic_id:@topic.id,
          post: attributes_for(:post)
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: @post, topic_id: @topic.id
        expect(response).to redirect_to new_user_session_url
      end
    end   
  end		
end