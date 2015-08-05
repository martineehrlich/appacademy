class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true
  validates :contact_id, presence: true, uniqueness: true {scope: :user_id}
  validate :user_cant_share_same_contact_twice

  belongs_to(
    :user,
    dependent: :destroy,
    foreign_key: :user_id,
    class_name: :User
  )

  belongs_to :contact,
    dependent: :destroy,
    foreign_key: :contact_id,
    class_name: :Contact

  def user_cant_share_same_contact_twice
    ContactShare.where(user_id: self.user_id, contact_id: self.contact_id)
    user = User.find_by(id: self.user_id)
    contact = Contact.find_by(id: self.contact_id)
    unless user.shared_contacts.include?(contact)
      errors[:user_id] << "You already shared that contact"
    end
  end

end
