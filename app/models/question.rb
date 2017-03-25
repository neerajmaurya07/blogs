class Question < ApplicationRecord
	belongs_to :article, :dependent => :destroy
	has_many :answers, :dependent => :destroy
  	accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end