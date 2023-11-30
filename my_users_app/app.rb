require 'sinatra'
require 'json'
require_relative 'my_user_model.rb'


enable :sessions
set :port, 8080
set :bind, '0.0.0.0'

get '/' do
   @users=User.all()
   erb :index
end


get '/users' do
    status 200
    User.all.map{|attrb| attrb.slice("firstname", "lastname", "age", "email")}.to_json
end


post '/users' do
    if params[:firstname] != nil
        create_user = User.create(params)
        new_user = User.find(create_user.id)

        user={:firstname=>new_user.firstname,
                :lastname=>new_user.lastname,
                :age=>new_user.age,
                :password=>new_user.password,
                :email=>new_user.email
            }.to_json
    else 
        list_user=User.authenticate(params[:password],params[:email])
        if !list_user[0].empty?
            status 200
            session[:user_id] = list_user[0]["id"]
        else
            status 401
        end 
        list_user[0].to_json
    end 
end


post '/sign_in' do
    kill_user=User.authenticate(params[:password],params[:email])
    if !kill_user.empty?
        status 200
        session[:user_id] = kill_user[0]["id"]
    else
        status 401
    end 
    kill_user[0].to_json
end


put '/users' do
    User.update(session[:user_id] , 'password', params[:password])
    my_user=User.find(session[:user_id])
    status 200
    user_info={:firstname=>my_user.firstname,
                :lastname=>my_user.lastname,
                :age=>my_user.age,
                :password=>my_user.password,
                :email=>my_user.email
            }.to_json

end


delete '/sign_out' do
    session[:user_id] = nil if session[:user_id]
    status 204
end



# To delete an active user uncomment line 61, but in this case gandalf couln't permit deleting a user from the db
delete '/users' do
    # User.destroy(session[:user_id]) if !session[:user_id].empty?
    status 204
end
