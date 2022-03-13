# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  role                   :integer          default("0")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :timeoutable

  has_one_attached :avatar
  has_many :articles, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  # validates :username, presence :true, :unique =>  true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # user roles in the application
  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end

  after_commit :add_default_avatar, on: %i[ create update ]

  def avatar_thumbnail
    if avatar.attached?
    avatar.variant(resize_to_limit: [150, nil])
    else
      "/default_avatar.jpg"
    end
  end
  
  def full_name
    first_name + " " + last_name
  end
  

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join( 'app', 'assets', 'images', 'default_avatar.jpg')
        ), filename: 'default_avatar.jpg', content_type: 'image/jpg'
      )
    end
  end
end
