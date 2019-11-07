class NamespaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return record.errors.add(attribute, 'は既に使用されています。') \
      if value =~ PathRegex.root_namespace_path_regex
  end
end
