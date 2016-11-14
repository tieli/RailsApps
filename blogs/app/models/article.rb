class Article < ActiveRecord::Base
  belongs_to :category

  scope :hidden, -> { where("hidden != ? ", true) }
  scope :published, lambda { where("published_at <= ?", Time.zone.now) }

  after_commit :flush_cache

  # for pagination
  self.per_page = 10
  
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
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

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 5.minutes) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def cached_comments_count
    Rails.cache.fetch([self, "comments_count"]) { comments.size }
  end

  def cached_comments
    Rails.cache.fetch([self, "comments"]) { comments.to_a }
  end

end
