require_dependency 'projects_helper'

module ProjectsHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :project_settings_tabs, :akayagi
    end
  end
end

module InstanceMethods
  def project_settings_tabs_with_akayagi
    tabs = project_settings_tabs_without_akayagi
    action = {:name => 'akayagi', 
        :controller => 'akayagi', 
        :action => :settings, 
        :partial => 'akayagi/settings', 
        :label => :tab_label}
    tabs << action if User::current.allowed_to?(action, @project)
    tabs
  end
end
