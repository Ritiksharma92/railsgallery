class Album < ApplicationRecord
    belongs_to :user
    has_one_attached :cover_picture
    has_many_attached :images
    has_many :taggings
    has_many :tags, through: :taggings, :dependent => :delete_all 
    
    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
      end
      
      def all_tags
        self.tags.map(&:name).join(", ")
      end

    validates :album_name, presence: true
    validates :created_by, presence: true
    validates :description, presence: true, length: {minimum: 10}
end
