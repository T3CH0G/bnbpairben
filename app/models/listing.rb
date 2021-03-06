class Listing < ActiveRecord::Base
     belongs_to :user
			has_many :taggings
			has_many :tags, through: :taggings
			mount_uploaders :avatars, AvatarUploader
			acts_as_bookable preset: :room

def self.tagged_with(name)
  Tag.find_by(name: name).listings
end

def self.tag_counts
  Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
end

def tag_list
  tags.map(&:name).join(", ")
end

def tag_list=(names)
  self.tags = names.split(",").map do |n|
    Tag.where(name: n.strip).first_or_create!
  end
end
searchkick match: :word_start, searchable: [:title, :location]
end