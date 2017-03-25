class Article < ApplicationRecord
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings
	belongs_to :user
	has_many :questions	
	accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? },  :allow_destroy => true
	def self.tagged_with(name)
	  Tag.find_by_name!(name).articles
	end

	def self.tag_counts
	  Tag.select("tags.*, count(taggings.tag_id) as count").
	    joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
	  tags.map(&:name).join(", ")
	end

	def tag_list=(names)
	  self.tags = names.split(",").map do |n|
	    Tag.where(name: n.strip).first_or_create!
	  end
	end
end
