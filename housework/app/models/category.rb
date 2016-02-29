class Category < ActiveRecord::Base
  has_many :tasks

  has_many :subcategories, :foreign_key => "parent_id", class_name: "Category"
end
