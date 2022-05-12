class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
        #検索ワード
		@content = params[:content]
        #検索方法
		@method = params[:method]
		@records = Product.search_for(@content, @method)
	end
end