require 'rubygems'
require 'stringio'
require 'test/unit'
require 'mocha'
require 'shoulda'

require File.dirname(__FILE__) + '/../lib/qadmin'


# mock AR::BASE
module ActiveRecord
  class Base
    class << self
      attr_accessor :pluralize_table_names
      
      def protected_attributes
        []
      end
      
    end
    self.pluralize_table_names = true
  end
end



class MockColumn
  attr_accessor :name, :type

  def initialize(name, type)
    self.name = name
    self.type = type
  end

  def human_name
    name.to_s.humanize
  end
  
  def default
    nil
  end
end

class Item < ActiveRecord::Base

  class << self

    def content_columns
      columns = {
        :name => :string,
        :sku  => :string,
        :description => :text,
        :made_at => :datetime,
        :price => :float,
        :created_at => :datetime,
        :updated_at => :datetime
      }
      columns.collect do |name, type|
        MockColumn.new(name, type)
      end
    end
  end
end

class MockController
  class << self
    def append_view_path(paths)
    end
  end
  
  extend Qadmin::Controller::Macros
end