class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  scope :upcoming, -> { where('starts_at > ?', Time.now.utc).order starts_at: :asc }
  scope :search, ->(query) { 
    where 'name ilike :query or extended_html_description ilike :query', query: "%#{ query }%" 
  }

  def is_upcoming?
    self[:starts_at] > Time.now.utc
  end
end
