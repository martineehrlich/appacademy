require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable

  def where(params)
    array = []
    where_line = params.each { |k,v| array << "#{k} = ?" }
    values = params.values
    array = array.join(" AND ")

    results = DBConnection.execute(<<-SQL, *values)
       SELECT
         *
       FROM
         #{self.table_name}
       WHERE
        #{array}
        SQL
      parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
