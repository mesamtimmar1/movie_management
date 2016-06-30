class Movie < ActiveRecord::Base
  has_many :posters, class_name: "Attachment", as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :posters, allow_destroy: true
  has_many :casts
  has_many :actors, through: :casts

  def show_desc
    self.description.to_s.html_safe
  end

  def show_trailer
    self.trailer.to_s.html_safe
  end

  def actor_names
    self.actors.pluck(:name).join(', ')
  end

  def duration_in_hour_minutes
   seconds = duration.to_i * 60
   Time.at(seconds).utc.strftime("%H:%M:%S")
  end
end
