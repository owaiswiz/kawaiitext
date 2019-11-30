module KawaiiText
  class TextLayerConfig 
    attr_accessor :pointsize, :stroke_width, :stroke_color, :stroke_fill_color

    def self.default
      config = TextLayerConfig.new
      config.pointsize = 72
      config.stroke_width = 3
      config.stroke_color = "none"
      config.stroke_fill_color = "none"
      config
    end
  end

  class PrimaryTextLayerConfig < TextLayerConfig
    def self.default
      config = TextLayerConfig.default
      config.stroke_fill_color = "white"
      config
    end
  end

  class OffsetTextLayerConfig < TextLayerConfig
    def self.default
      config = TextLayerConfig.default
      config.stroke_color = "green"
      config
    end
  end
end
