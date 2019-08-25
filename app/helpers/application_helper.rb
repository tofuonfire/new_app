module ApplicationHelper
  
  def website_name
    "Mewblr"
  end

  # ページごとの完全なタイトルを返します
  def full_title(page_title = '')
    base_title = website_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def date_format(datetime)
    time_ago_in_words(datetime) + '前'
  end
end
