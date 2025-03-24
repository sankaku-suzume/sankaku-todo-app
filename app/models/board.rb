# == Schema Information
#
# Table name: boards
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
class Board < ApplicationRecord
  
  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 100 }
  validates :name, format: { with: /\A(?!\@)/ }

  validates :description, presence: true
  validates :description, length: { minimum: 2 }
  
  has_many :tasks, dependent: :destroy
  belongs_to :user


end
