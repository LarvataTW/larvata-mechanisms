module Larvata::Mechanisms::Concerns::DatatablesQuery
  extend ActiveSupport::Concern

  included do
    private

    # 設定 ransack 查詢
    def query(scope, keyword_field)
      handle_filters(scope.class.to_s)

      handle_keyword(keyword_field)

      @query = scope.ransack(@filters)

      handle_sort_filter
    end

    # 設定 ransack 查詢條件
    def handle_filters(class_name)
      @filters = DatatablesService.new({ class_name: class_name }).handle_filters(params)
    end

    # 設定 ransack 關鍵字查詢
    def handle_keyword(keyword_field)
      @keyword = params[:search][:value] unless params[:search].blank?
      @filters[keyword_field.to_sym] = @keyword if @keyword.present?
    end

    # 設定 ransack 排序
    def handle_sort_filter(default_sort_filter = 'updated_at desc')
      @query.sorts = params[:order] ? get_sorting : default_sort_filter
    end

    # 處理 datatables 的排序參數與分頁頁數
    def datatables_order
      unless params[:order].blank?
        sorting_key_and_dir
        @page = (params[:start].to_i / params[:length].to_i) + 1 # 顯示資料的頁數
      end
    end

    # 整理要排序的欄位, ex：[{:column=>"5", :dir=>"desc"}, {:column=>"10", :dir=>"asc"}]
    def sorting_key_and_dir
      @sorting_key_and_dir, i = [], 0
      loop do
        @sorting_key_and_dir << { column: params[:order][i.to_s][:column], dir: params[:order][i.to_s][:dir] }
        break unless params[:order][(i + 1).to_s]
        i += 1
      end
    end

    # 彙整為 ransack 多欄位排序格式, ex：["state desc", "is_top desc"]
    def get_sorting
      @sorting_key_and_dir.reduce([]) { |s, i| s << "#{params[:columns][i[:column]][:data]&.gsub('.', '_')&.gsub('_text', '')} #{i[:dir]}" }
    end
  end
end