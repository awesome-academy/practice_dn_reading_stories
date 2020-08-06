module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
    end

    def remember(user)
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Returns the current logged-in user (if any).
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def current_user?(user)
        user && user == current_user
    end

    def logged_in?
        !current_user.nil?
    end

    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end
end
