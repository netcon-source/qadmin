require File.join(File.dirname(__FILE__), '..', 'lib', 'qadmin')

ActionController::Base.send(:extend, Qadmin::Controller)
ActionView::Base.send(:include, Qadmin::Helper)