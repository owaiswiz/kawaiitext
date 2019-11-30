require "rmagick"

module KawaiiText
  class Generator
    SUPPORTED_BACKGROUND_FILEFORMATS = ["jpg", "jpeg", "png", "gif"]
    BACKGROUND_TO_TEXT_LAYER_WIDTH_RATIO = 1.15
    BACKGROUND_TO_TEXT_LAYER_HEIGHT_RATIO = 1.05

    def initialize text:, font_path: nil, backgrounds_folder: nil, background_filepath: nil, supported_formats: nil, pointsize: nil, stroke_width: nil, stroke_color: nil, fill_color: nil, working_directory: nil 
      @text = text
      @font_path = font_path
      @backgrounds_folder = backgrounds_folder || KawaiiText.backgrounds_dir
      @background_filepath = background_filepath
      @working_directory = working_directory
      @supported_formats = supported_formats || SUPPORTED_BACKGROUND_FILEFORMATS
      @pointsize = pointsize || 72
      @stroke_width = stroke_width || 3
      @stroke_color = stroke_color || "green"
      @fill_color = fill_color || "none"
      @working_directory = working_directory || "live_image_preview"

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
      text_layer_height = (@background_image.rows / BACKGROUND_TO_TEXT_LAYER_HEIGHT_RATIO).round

      command = ["convert"]
      command << "-size #{text_layer_width}x#{text_layer_height}"
      command << "-gravity center"
      command << "-font #{@font_path}" if @font_path
      command << "-background transparent"
      command << "-pointsize #{@pointsize}"
      command << "-fill white"
      command << "-interline-spacing #{@pointsize/2}"
      command << "caption:\"#{@text}\""
      command << "#{@working_directory}/op.png"

      `#{command.join " "}`
    end
      command << "-interline-spacing #{@pointsize/2}"
      command << "caption:\"#{@text}\""
      command << "live_image_preview/op.png"
      `#{command.join " "}`
    end

      exec(command.join " ")
    end
  end
end
