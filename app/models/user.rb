class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many  :posts
  has_friendship
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def self.search(search)
    where("nickname LIKE ?", "%#{search}%")
  end
  
  def authority?(post)
    self.id == post.user_id
  end
  
  def read_authority?(post)
    if post.read_scope == 3
      if self.id == post.user_id
        true
      else
        false
      end
    elsif post.read_scope == 2
      if self.id == post.user_id or self.friends_with?(post.user)
        true
      else
        false
      end
    elsif post.read_scope == 1
     true
    end
  end
end
