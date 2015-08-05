# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: %w(APPROVED DENIED PENDING)}
  validate :overlapping_approved_requests
  after_initialize :set_pending_status

  belongs_to :cat,
    dependent: :destroy,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    overlapping_requests = []

    # CatRentalRequest.where(self.cat_id: request.cat_id).where(self.id != request.id)
    CatRentalRequest.all.each do |request|
      if self.cat_id == request.cat_id && self.id != request.id
        if self.start_date.between?(request.start_date, request.end_date) &&
          self.end_date.between?(request.start_date, request.end_date)
          overlapping_requests << request
        end
      end
    end
    overlapping_requests
  end

  def overlapping_approved_requests
    if self.status == 'APPROVED'
      if overlapping_requests.any? do |request|
        request.status == 'APPROVED'
      end
        errors[:status] << "That cat is already booked, sorry."
      end
    end
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == 'PENDING' }
  end

  def approve!
    ActiveRecord::Base.transaction do
      self.status = 'APPROVED'
      self.save
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  protected

  def set_pending_status
    self.status ||= 'PENDING'
  end
end
