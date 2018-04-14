class ApplicationController < ActionController::Base
  
  protected
    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_index_path
      else
        root_path
      end
    end
end
