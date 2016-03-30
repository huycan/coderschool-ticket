class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types
  has_many :tickets, through: :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  scope :upcoming, -> { where('starts_at > ?', Time.now.utc).order starts_at: :asc }
  scope :search, ->(query) { 
    where 'name ilike :query or extended_html_description ilike :query', query: "%#{ query }%" 
  }

  scope :viewable, ->(user_id) { where("published=true or user_id = ?", user_id) }

  def is_upcoming?
    self[:starts_at] > Time.now.utc
  end

  def publishable?
    self.ticket_types.count > 0
  end

  def publish!
    self[:published] = true
  end
end
