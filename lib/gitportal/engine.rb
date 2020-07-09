module Gitportal
  class Engine < ::Rails::Engine
    isolate_namespace Gitportal

    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper Gitportal::ApplicationHelper
      end
    end    
  end
end
