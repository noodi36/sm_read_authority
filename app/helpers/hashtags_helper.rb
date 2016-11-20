module HashtagsHelper
  def linkify_hashtags(hashtaggable_content)
    regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
    hashtagged_content = hashtaggable_content.to_s.gsub(regex).each do |h|
      link_to $&,"/hashtags/:hashtag?search=#{h.delete('#').gsub(" ","")}"
      #link_to h,"/hashtags/:hashtag?search=#{h}"
      #hashtag.name, hashtag_path(hashtag.name)
      #link_to (h, "/hashtags/:hashtag?search=#{h}")
      
    end
    hashtagged_content.html_safe
  end

  def render_hashtaggable(hashtaggable)
    klass        = hashtaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view}/#{partial}", {klass.to_sym => hashtaggable}
  end
end
