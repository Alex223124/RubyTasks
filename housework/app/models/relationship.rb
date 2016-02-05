class Relationship < ActiveRecord::Base
  belongs_to :parent, :foreign_key => "parent_id", :class_name => "User"
  belongs_to :child, :foreign_key => "child_id", :class_name => "User"
end
