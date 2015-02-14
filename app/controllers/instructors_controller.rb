class InstructorsController < ApplicationController
  def index
    @instructors = User.all.select {|u| u.sections.any? }.sort_by { |u| u.last }
  end
end
