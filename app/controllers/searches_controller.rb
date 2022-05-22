class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
        #検索ワード
		@content = params[:content]
        #検索方法
		@method = params[:method]
		if @model == 'product'
			@records = Product.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_products_for(@content, @method)
		end
	end
end
