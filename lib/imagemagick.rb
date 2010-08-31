module Imagemagick

  # Define options for this plugin via the <tt>configure</tt> method
  # in your application manifest:
  #
  #   configure(:imagemagick => {:foo => true})
  #
  # Then call the recipe:
  #
  #  recipe :imagemagick
  def imagemagick(options = {})
    %w(
      imagemagick
      libmagick9-dev
    ).each do |p|
      package p, :ensure => :installed, :before => exec('rails_gems')
      symlink_to_local if options[:symlink_to_local]
    end
  end

  protected

  def symlink_to_local
    ['convert', 'identify'].each do |im_command|
      exec "symlink_#{im_command}", {
        :command => "ln -nfs /usr/bin/#{im_command} /usr/local/bin/#{im_command}",
        :unless => "ls -al /usr/local/bin | grep #{im_command}",
        :require => [
          package("imagemagick"),
          package("libmagick9-dev")
        ]
      }
    end
  end
end