class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :tickets

  def remaining?
    self[:max_quantity] - self.tickets.collect { |t| t.quantity } .sum
  end

  def buyable? quantity
    self.remaining? >= quantity
  end
end
