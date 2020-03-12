class Paramedic < ApplicationRecord
  has_many :cases
  # has_many :drugs
  belongs_to :paramedic_type
  has_one :organization, through: :paramedic_type
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :employee_num, uniqueness: true
  # validates :employee_num, presence: true, uniqueness: true
  # paramedic_type_id could do with an inclusion validation once paramedic_types have been created.
  validates :paramedic_type_id, presence: true

  accepts_nested_attributes_for :cases
end
