class Relationship < ActiveRecord::Base
  belongs_to :user, :foreign_key => "parent_id", :class_name => "User"
  belongs_to :childs, :foreign_key => "child_id", :class_name => "User"
end
