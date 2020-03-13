class Admin < ApplicationRecord
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include AlgoliaSearch
  algoliasearch do
    attributes :first_name, :last_name, :email, :organization_id, :employee_num
    searchableAttributes ['first_name', 'last_name', 'email', 'organization_id', 'employee_num']
  end
end
