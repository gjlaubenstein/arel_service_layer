class ActiveRepository
  def initialize(connection: ActiveRecord::Base.connection, sql_ast: Arel)
    @connection = connection
    @model = get_model
    @table = get_table(sql_ast)
  end

  def find_by(column:, value:)
    sql = table
      .where(table[column].eq(value))
      .project(get_model_columns)
      .to_sql

    convert(connection.exec_query(sql))
  end

  def find_all
    sql = table
      .project(get_model_columns)
      .to_sql

    convert(connection.exec_query(sql))
  end

  def insert(data)
    sql = table
      .create_insert
      .insert(build_insert(data))
      .to_sql

    convert(connection.exec_query(sql))
  end

  private
  attr_reader :connection, :model, :table

  def convert(result)
    result.to_a.map { |record| model.new(record) }
  end

  def build_insert(data)
    statement = []
    data.instance_values.each do |key, value|
      statement << [table[key], value]
    end

    statement
  end

  def get_model_columns
    model.instance_methods(false).map { |attr| table[attr] }
  end

  def get_table(sql_ast)
    table_name = model.to_s.downcase.pluralize
    sql_ast::Table.new(table_name)
  end

  def get_model
    Object.const_get(self.class.to_s.split("Repository").first.singularize)
  end
end
