require "rmagick"

module KawaiiText
  class Generator
    SUPPORTED_BACKGROUND_FILEFORMATS = ["jpg", "jpeg", "png", "gif"]
    BACKGROUND_TO_TEXT_LAYER_WIDTH_RATIO = 1.15
    BACKGROUND_TO_TEXT_LAYER_HEIGHT_RATIO = 1.05
    PRIMARY_TEXT_LAYER_FILENAME = "primary"
    OFFSET_TEXT_LAYER_FILENAME = "offset"
    MERGED_TEXT_LAYER_FILENAME = "merged"
    FINAL_OUTUT_FILENAME = "output"

    def initialize text:, font_path: nil, backgrounds_folder: nil, background_filepath: nil, supported_formats: nil, working_directory: nil, primary_text_layer_config: nil, offset_text_layer_config: nil
      @text = text
      @font_path = font_path
      @backgrounds_folder = backgrounds_folder || KawaiiText.backgrounds_dir
      @background_filepath = background_filepath
      @working_directory = working_directory
      @supported_formats = supported_formats || SUPPORTED_BACKGROUND_FILEFORMATS
      @working_directory = working_directory || "live_image_preview"

      @primary_text_layer_config = primary_text_layer_config || PrimaryTextLayerConfig.default
      @offset_text_layer_config = offset_text_layer_config || OffsetTextLayerConfig.default

      @background_filepath ||= get_random_background_from_backgrounds_folder
      @background_image = open_image @background_filepath

      generate_primary_text_layer
      generate_offset_text_layer
      merge_text_layers
      merge_text_and_background_layers
    end

    private
    def open_image file_path
      Magick::ImageList.new(file_path)
    end

    def get_random_background_from_backgrounds_folder
      files = Dir["#{@backgrounds_folder}/**/**.{#{@supported_formats.join(',')}}"]
      files.sample
    end

    def generate_primary_text_layer 
      generate_text_layer @primary_text_layer_config, PRIMARY_TEXT_LAYER_FILENAME
    end

    def generate_offset_text_layer 
      generate_text_layer @offset_text_layer_config, OFFSET_TEXT_LAYER_FILENAME
    end

    def generate_text_layer text_layer_config, output_file_name
      text_layer_width = (@background_image.columns / BACKGROUND_TO_TEXT_LAYER_WIDTH_RATIO).round
      text_layer_height = (@background_image.rows / BACKGROUND_TO_TEXT_LAYER_HEIGHT_RATIO).round

      command = ["convert"]
      command << "-size #{text_layer_width}x#{text_layer_height}"
      command << "-background transparent"
      command << "-font #{@font_path}" if @font_path
      command << "-gravity center"
      command << "-pointsize #{text_layer_config.pointsize}"
      command << "-strokewidth #{text_layer_config.stroke_width}"
      command << "-stroke #{text_layer_config.stroke_color}"
      command << "-fill #{text_layer_config.stroke_fill_color}"
      command << "-interline-spacing #{text_layer_config.pointsize/2}"
      command << "caption:\"#{@text}\""
      command << "#{@working_directory}/#{output_file_name}.png"

      `#{command.join " "}`
    end

    def merge_text_layers
      file_1_path = "#{@working_directory}/#{PRIMARY_TEXT_LAYER_FILENAME}.png" 
      file_2_path = "#{@working_directory}/#{OFFSET_TEXT_LAYER_FILENAME}.png" 
      file_output_path = "#{@working_directory}/#{MERGED_TEXT_LAYER_FILENAME}.png"
      merge_images offset: "-3+4", file_1_path: file_1_path, file_2_path: file_2_path, file_output_path: file_output_path
    end

    def merge_text_and_background_layers
      file_1_path = "#{@working_directory}/#{MERGED_TEXT_LAYER_FILENAME}.png" 
      file_2_path = @background_filepath
      file_output_path = "#{@working_directory}/#{FINAL_OUTUT_FILENAME}.png"
      merge_images file_1_path: file_1_path, file_2_path: file_2_path, file_output_path: file_output_path
    end

    def merge_images offset: nil, file_1_path:, file_2_path:, file_output_path:
      command = ["composite"]
      command << "-dissolve 100"
      command << "-gravity center"
      command << "-geometry #{offset}" if offset
      command << file_1_path
      command << file_2_path
      command << "-alpha Set"
      command << file_output_path

      `#{command.join " "}`
    end
  end
end
