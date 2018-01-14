class Image < ActiveRecord::Base
  belongs_to :user
  
  ## :picture is the image model column name
  mount_uploader :picture, PictureUploader 
  
  validate :picture_size
  
  private
  def picture_size
    if picture.size > 10.megabytes
      errors.add(:picture, "should be less than 10 MB")
    end
  end
  
end
