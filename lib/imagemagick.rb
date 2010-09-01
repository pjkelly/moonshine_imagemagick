module Imagemagick

  # Just call the recipe:
  #
  #  recipe :imagemagick
  def imagemagick(options = {})
    %w(imagemagick libmagick9-dev).each do |p|
      package p, :ensure => :installed, :before => exec('rails_gems')
    end
  end

end