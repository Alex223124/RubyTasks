class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks

  has_many :parent_relationships, :foreign_key => "parent_id", :class_name => "Relationship"
  has_many :children, :through => :parent_relationships

  has_many :child_relationships, :foreign_key => "child_id", :class_name => "Relationship"
  has_many :parents, :through => :child_relationships
end
