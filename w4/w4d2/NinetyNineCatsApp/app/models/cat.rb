# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :color,
            inclusion: {
              in: %w(black grey white brown),
              message: "%{value} is not a valid color"
            }
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, length: {maximum: 1}, inclusion: {in: %w(M F), message: "%{value} is not a valid sex" }
  COLORS = ['brown', 'black', 'grey', 'white']
  def age
    @birth_date = self.birth_date
    age_in_days = (Date.today - @birth_date).to_i
    age = age_in_days/365
  end
  has_many :cat_rental_requests,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest

  def show_attributes
    {name: name,
      age: age,
      color: color,
      sex: sex,
    }
  end
end
