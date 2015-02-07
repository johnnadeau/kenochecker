class InclusiveArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    range = options[:range]
    if value.any? { |n| !range.include? n }
      record.errors[attribute] << (options[:message] || 'has values outside of the range')
    end
  end
end
