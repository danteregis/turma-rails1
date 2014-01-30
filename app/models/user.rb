# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  password       :string(255)
#  email          :string(255)
#  cpf            :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  poker_table_id :integer
#

class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  #validates_confirmation_of :password
  
  #validates :email, presence: true, uniqueness: true
  
  belongs_to :poker_table, inverse_of: :users
  
  
  validate :check_amount 
  
  def check_amount
    if self.money < 0
      errors.add(:money, "Não pode ser menor do que 0")
    end
  end
end
