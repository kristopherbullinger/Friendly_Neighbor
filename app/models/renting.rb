class Renting < ApplicationRecord
  #validates :proposed_duration, numericality: {greater_than: 0}
  belongs_to :item
  belongs_to :user ######BORROWER
  has_one :review

  def calculate_cost(hours)
    ####TODO: Hours are ahead by four hours for some reason
    #total_hours = ((DateTime.current - DateTime.parse(Renting.first.created_at.to_s)).to_f*24).round(2)
    self.final_price = self.item.price.to_f * hours
    self.save
  end

  def display_cost
    sprintf('%.2f',self.final_price)
  end

  def calculate_due_date
    date = self.created_at + self.proposed_duration.hour
  end

  def display_due_date
    date = self.created_at + self.proposed_duration.hour
    date.localtime.strftime("Item due back on %m/%d/%Y, at %I:%M%p")
  end

  def new_review
    Review.new(:renting_id => self.id)
  end
end
