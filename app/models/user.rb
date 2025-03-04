class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :licenses
  has_many :softwares, through: :licenses
  has_many :reviews, through: :licenses
  has_many :softwares, through: :licenses
end
