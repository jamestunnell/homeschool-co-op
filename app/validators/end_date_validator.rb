class EndDateValidator < ActiveModel::Validator
  def validate(term)
    if term.errors[:end_date].empty? && term.errors[:start_date].empty?
      unless term.end_date >= term.start_date
        term.errors[:end_date] << 'End date must be >= start date.'
      end
    end
  end
end
