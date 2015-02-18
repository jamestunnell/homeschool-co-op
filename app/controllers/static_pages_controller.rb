class StaticPagesController < ApplicationController
  def home
    @date_descriptions = []
    @upcoming_terms = Term.upcoming.each do |t|
      @date_descriptions.push [t.start_date, "First day of #{t.name}"]
      @date_descriptions.push [t.end_date, "Last day of #{t.name}"]
    end

    Event.upcoming.each do |e|
      @date_descriptions.push [e.start_time, e.title]
    end

    @date_descriptions = @date_descriptions.sort_by {|date,descr| date }
  end

  def about
  end

  def contact
  end

  def register
  end
end
