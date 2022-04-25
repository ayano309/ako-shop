module DisplayList

  # 重複したscopeまとめる
  
  PER = 15

  def display_list(page)
    page(page).per(PER)
  end
end