module ApplicationHelper
  def range_with_dash range
    "#{range.min}#{range.min == range.max ? "" : "-#{range.max}"}"
  end
  module_function :range_with_dash

  def phone_formatted phone_str
    phone_str.phony_formatted(:format => :international, :spaces => ".")
  end
end
