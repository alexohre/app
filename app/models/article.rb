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
  enum status: {draft: 0, publish: 1, archive: 2}
end
