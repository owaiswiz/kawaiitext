module KawaiiText
  def self.root
    File.dirname __dir__
  end

  def self.assets
    File.join root, 'assets'
  end

  def self.backgrounds_dir
    File.join assets, 'backgrounds' 
  end

  def self.fonts_dir
    File.join assets, 'fonts' 
  end
end
