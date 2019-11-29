require "rmagick"

module KawaiiText
  class Generator
    SUPPORTED_BACKGROUND_FILEFORMATS = ["jpg", "jpeg", "png", "gif"]
    BACKGROUND_TO_TEXT_LAYER_WIDTH_RATIO = 1.15

    def initialize text:, font_path: nil, backgrounds_folder: KawaiiText.backgrounds_dir, background_filepath: nil, supported_formats: SUPPORTED_BACKGROUND_FILEFORMATS, pointsize: 72
      @text = text
      @font_path = font_path
      @backgrounds_folder = backgrounds_folder
      @background_filepath = background_filepath
      @supported_formats = supported_formats
      @pointsize = pointsize

      @background_filepath ||= get_random_background_from_backgrounds_folder

      @background_image = open_image @background_filepath
      generate_text_layer
    end

    private
    def open_image file_path
      Magick::ImageList.new(file_path)
    end

    def get_random_background_from_backgrounds_folder
      files = Dir["#{@backgrounds_folder}/**/**.{#{@supported_formats.join(',')}}"]
      files.sample
    end

    def generate_text_layer
      text_layer_width = (@background_image.columns / BACKGROUND_TO_TEXT_LAYER_WIDTH_RATIO).round

      command = ["convert"]
      command << "-size #{text_layer_width}x"
      command << "-gravity center"
      command << "-font #{@font_path}" if @font_path
      command << "-pointsize #{@pointsize}"
      command << "-interline-spacing #{@pointsize/2}"
      command << "caption:\"#{@text}\""
      command << "live_image_preview/op.png"

      exec(command.join " ")
    end
  end
end
