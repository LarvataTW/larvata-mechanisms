class Larvata::Mechanisms::DatatablesService
  def initialize(*args)
    class_name = args&.first[:class_name] if args&.first
    @class_const = class_name&.constantize
  end

  def handle_filters(params)
    filters = {}

    search_columns = params[:columns]&.select{|index, column| column[:search][:value].present? }
    search_columns&.each{|index, column|
      search_column = column[:name]
      search_value = column[:search][:value]

      if search_column.include? "_between" # 區間查詢
        search_column = search_column.gsub('_between', '')
        search_value_array = search_value.split(" - ")
        start_value = search_value_array[0]
        end_value = search_value_array[1]

        filters["#{search_column}_gteq".to_sym] = start_value if start_value.present?
        filters["#{search_column}_lteq".to_sym] = end_value if end_value.present?
      elsif search_column.include? "_enum" # enum 查詢
        search_column = search_column.gsub('_enum', '')

        # 使用 enumerize 套件來取代原始 rails 的 enum 方法所以不需要再去取 enum 值 
        # plural_search_column = search_column.pluralize
        # search_value = @class_const&.send(plural_search_column)[search_value.to_sym]

        filters["#{search_column}_eq".to_sym] = search_value if search_value
      else
        filters[search_column.to_sym] = search_value if search_value
      end
    }

    return filters
  end
end

