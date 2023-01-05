# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true
end
