module PostsHelper
  include ActsAsTaggableOn::TagsHelper
  def date_format(date)
    date.strftime('%d.%m.%Y %H:%M')
  end
end
