module ApplicationHelper
  def range_with_dash range
    "#{range.min}#{range.min == range.max ? "" : "-#{range.max}"}"
  end
  module_function :range_with_dash

  def phone_formatted phone_str
    phone_str.phony_formatted(:format => :international, :spaces => ".")
  end

  def formal_date date_obj
    date_obj.strftime("%a, %b %-d, %Y")
  end

  def formal_date_time time_obj
    time_obj.strftime("%a, %b %-d, %Y at %l:%M %p")
  end
end
