require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminResetPoint
end

module RailsAdmin
  module Config
    module Actions
      class ResetPoint < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
      end
    end
  end
end
 
module RailsAdmin
  module Config
    module Actions
      class ResetPoint < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here. 
        # Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
 
        register_instance_option :bulkable? do
          true
        end
 
        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
 
            # Update field points to 0
            @objects.each do |object|
              object.update_attribute(:points, 0)
            end
 
            flash[:success] = "#{@model_config.label} successfully reseted."
 
            redirect_to back_or_index
          end
        end
      end
    end
  end
end