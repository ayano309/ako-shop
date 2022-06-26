class Tag < ApplicationRecord
# タグは複数の投稿を持つ それは、item_tagsを通じて参照できる
  has_many :item_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :products, through: :item_tags, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  #検索
  def self.search_products_for(content, method)
    if method == 'perfect'
      tags = Tag.where(name: content)
    end

    # injectはたたみ込み演算
    return tags.inject(init = []) {|result, tag| result + tag.products}

  end
end
