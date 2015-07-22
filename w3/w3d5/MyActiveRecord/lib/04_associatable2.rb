require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      through_options_pk = through_options.primary_key
      through_options_fk = through_options.foreign_key
      through_options_classname = through_options.class_name
      source_options_pk = source_options.primary_key
      source_options_fk = source_options.foreign_key
      source_options_classname = source_options.class_name

    result =  DBConnection.execute(<<-SQL, self.send(through_options_fk))
      SELECT
        #{source_options.table_name}.*
      FROM
        #{through_options.table_name}
      JOIN
        #{source_options.table_name} ON #{through_options.table_name}.#{source_options_fk} = #{source_options.table_name}.id
      WHERE
        #{through_options.table_name}.id = ?
        SQL
      source_options_classname.constantize.parse_all(result).first
    end
  end
end
