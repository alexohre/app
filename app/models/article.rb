# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  status     :integer          default("0")
#  featured   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  has_many :comments, as: :commentable
  
  validates :title, presence: true, length: {minimum: 6}
  has_rich_text :content
  has_one_attached :image
  
  
  enum status: {draft: 0, publish: 1}
end
