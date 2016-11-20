class Post < ActiveRecord::Base
    include SimpleHashtag::Hashtaggable
    belongs_to  :user
    hashtaggable_attribute :content
    
    def self.search(search)
        where("content LIKE ?", "%#{search}%")
    end
end
