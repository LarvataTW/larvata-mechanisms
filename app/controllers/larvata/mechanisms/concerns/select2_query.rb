module Larvata::Mechanisms::Concerns::Select2Query
  extend ActiveSupport::Concern

  included do
    private

    def select2_query_options
      @select2_per = params[:per]
      @select2_page = params[:page]
      @select2_filter = params[:search]
    end

    def select2_json_options(value_method, label_method)
      @select2_value_method = value_method
      @select2_label_method = label_method
    end

    def records_json
      @records.map{|record| {id: record.try(@select2_value_method), text: record.try(@select2_label_method)}}
    end

    def select2_json
      {
        results: records_json,
        filtered_count: @pagy.count,
        per: @per
      }
    end

    # 設定 ransack 查詢
    def select2_query(scope, keyword_field, sorts)
      @select2_query = scope.ransack(:"#{keyword_field}" => @select2_filter)
      select2_sorts(sorts)
    end

    # 設定 ransack 排序
    def select2_sorts(sorts = 'updated_at desc')
      @select2_query.sorts = sorts
    end

    def select2_records_json(scope, keyword_field, sorts = 'updated_at desc', value_method: 'id', label_method: 'name')
      select2_query_options
      select2_json_options(value_method, label_method)
      select2_query(scope, keyword_field, sorts)
      @pagy, @records = pagy(@select2_query.result, items: @per, page: @page)
      select2_json
    end
  end
end