require "kawaii_text"

#Simple using defaults
KawaiiText::Generator.new text: "Daisy in a field of roses"

#Custom Background
KawaiiText::Generator.new text: "Everything I Wanted", background_filepath: "/home/owaiswiz/Projects/Ruby/kawaiitext/lib/assets/backgrounds/3.jpeg"

#Custom Offset Text Layer Settings - Similar can be done for primary layer (refer usage)
config = KawaiiText::OffsetTextLayerConfig.default
config.stroke_color = "\"#59C3C3\""
config.stroke_fill_color = "\"#DCB6D5\""
config.stroke_fill_color = "\"none\""
config.stroke_width = 2
KawaiiText::Generator.new text: "bury a friend", offset_text_layer_config: config

