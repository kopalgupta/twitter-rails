class AuthenticationController < ApplicationController
  def signin_get
  end

  def signup_get
  end

  def signin
    email = params[:email]
    password = params[:password]

    user = User.find_by_email(email)

    if user

      if user.password == password
        session[:user_id] = user.id
        return redirect_to '/'
      else
        return redirect_to '/signin'
      end

    else
      return redirect_to '/signup'
    end
  end


  def signup
    name = params[:name]
    email = params[:email]
    password = params[:password]
    handle = params[:handle]

    user = User.find_by_email(email)

    unless user
      user = User.create(name: name, email: email, password: password, handle: handle)
      session[:user_id] = user.id
      user.save
      return redirect_to '/'
    else
      return redirect_to '/signup'
    end
  end


  def logout
    session[:user_id] = nil
    return redirect_to '/'
  end
end
