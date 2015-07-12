require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    columns = DBConnection.execute2(<<-SQL)
     SELECT
      *
     FROM
      #{self.table_name}
    SQL

    @columns = columns.first.map! { |col| col.to_sym }
    @columns
  end

  def self.finalize!

    columns.each do |column|
        define_method("#{column}") do
          attributes[column]
        end

        define_method("#{column}=") do |value|
          attributes[column] = value
        end
      end

  end

  def self.table_name=(table_name)
      @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
  results =  DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |hash| self.new(hash) }
  end

  def self.find(id)
  result = DBConnection.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{self.table_name}.id = :id
    SQL
    parse_all(result).first
  end

  def initialize(params = {})
    params.each do |k,v|
      ivar = k.to_sym
      unless self.class.columns.include?(ivar)
        raise "unknown attribute '#{ivar}'"
      end
      self.send("#{k}=", v)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    col_names = self.class.columns.join(", ")
    question_marks = (["?"] * self.class.columns.length).join(", ")

   DBConnection.execute(<<-SQL, *self.attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.send(:id=,DBConnection.last_insert_row_id)
  end

  def update
    col_names = self.class.columns
    q_m = col_names[1..-1].map { |col|  "#{col} = ?" }.join(", ")
    values = self.attribute_values.rotate!

    DBConnection.execute(<<-SQL, values)
       UPDATE
         #{self.class.table_name}
       SET
        #{q_m}
       WHERE
        id = ?
     SQL
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
