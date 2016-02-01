class User < ActiveRecord::Base
  has_many :tasks

  has_many :relationships, :foreign_key => "parent_id", :class_name => "Relationship"
  has_many :childs, :through => :relationships
end
