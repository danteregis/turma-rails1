class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  #validates_confirmation_of :password
  
  #validates :email, presence: true, uniqueness: true
  
  belongs_to :poker_table, inverse_of: :users
  
  
end
