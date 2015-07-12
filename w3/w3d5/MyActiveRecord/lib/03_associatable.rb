require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.to_s.constantize
  end

  def table_name
    class_name.constantize.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
     :primary_key => :id,
     :class_name => name.capitalize,
     :foreign_key => "#{name}_id".to_sym
    }
    settings = defaults.merge(options)
     @primary_key = settings[:primary_key]
     @foreign_key = settings[:foreign_key]
     @class_name = settings[:class_name]
  end
end


class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {:primary_key => :id,
     :class_name => name.to_s.singularize.capitalize,
     :foreign_key => "#{self_class_name.to_s.downcase}_id".to_sym}
     settings = defaults.merge(options)
     @primary_key = settings[:primary_key]
     @foreign_key = settings[:foreign_key]
     @class_name = settings[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    #class scope
    define_method(name) do
      options.model_class.where(options.primary_key => self.send(options.foreign_key)).first
    end
  end

  def has_many(name, options = {})
    option = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      key_val = self.send(option.primary_key)
        option
          .model_class
          .where((option.foreign_key) => key_val)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
