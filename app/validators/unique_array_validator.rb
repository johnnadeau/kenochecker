class UniqueArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.uniq.count == value.count
      record.errors[attribute] << (options[:message] || 'is not an unique array')
    end
  end
end
