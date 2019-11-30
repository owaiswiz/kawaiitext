# KawaiiText
[![Gem Version](https://badge.fury.io/rb/kawaii_text.svg)](https://badge.fury.io/rb/ds18b20) [![Gem](https://img.shields.io/gem/dt/kawaii_text.svg?colorB=brightgreen&maxAge=3600)]() 


## What is this ?
Its a ruby gem to render your text to an image with fancy fonts and some effects with backgrounds. Might be suitable if
you ever had to generate these kind of things automatically for using them as cover or
header images. It makes use of ImageMagick for all image manipulations

## Why does this exist ?
I had a need for something like this for a project of mine and wasn't able to find anything that fit my use case.

## Examples
![Simple](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/simple.png?raw=true "Simple")

![Custom Background](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/custom_background.png?raw=true "Custom Background")

![Custom Offset Text Layer Config](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/custom_offset_textlayer_config.png?raw=true "Custom Offset Text Layer Config")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kawaii_text'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kawaii_text

## Usage

### 1. Require
```ruby
require "kawaii_text"
```

### 2. Basic Usage
By default, this gem randomly picks a background image and font along with a default color and some stroke styles. The output is saved to the same directory as the script is run in a file named "output.png".
```ruby
KawaiiText::Generator.new(text: "Daisy in a field of roses")
```
#### Output
![Simple](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/simple.png?raw=true "Simple")

### 3. Advanced Usage
The generator takes a lot of keyword arguments while initialization which can be used to modify various settings. The description of supported arguments and what they do are given below: 

1. **text** (required, *string*) - Specifies the text to be rendered.
 ```ruby
KawaiiText::Generator.new(text: "Daisy in a field of roses")
```
___
2. **font_path** (optional, *string*) - Specifies the font to be used (.ttf file). By default it randomly picks a font out of the 4 included with this library.
```ruby
KawaiiText::Generator.new(text: "bury a friend", font_path: "/home/owaiswiz/Roboto.ttf")
```
___
3. **background_filepath** (optional, *string*) - Specifies the background file to be used. By default, a folder with 4 backgrounds included with this library is used and a random file from that folder is selected.
```ruby
KawaiiText::Generator.new(text: "bury a friend", backgrounds_folder: "/home/owaiswiz/images/rak.png")
```
___
4. **backgrounds_folder** (optional, *string*) - Specifies the folder to be used for randomly picking a background. By default, a folder with 4 backgrounds included with this library is used. ***(Has no effect if background_filepath is specified)***.
```ruby
KawaiiText::Generator.new(text: "bury a friend", backgrounds_folder: "/home/owaiswiz/images")
```
___
5. **supported_formats** (optional, *array of strings*) - Specifies the file types to consider while randomly picking a background from backgrounds_folder. By default its value is ["jpg", "jpeg", "png", "gif"].  ***(Has no effect if background_filepath is specified)***.
```ruby
KawaiiText::Generator.new(text: "bury a friend", backgrounds_folder: "/home/owaiswiz/images", supported_formats: ["png", "bmp"])
```
___
6. **working_directory** (optional, *string*) - Specifies the path to the directory where output is saved. By default its value is the current directory from which you are running ruby.
```ruby
KawaiiText::Generator.new(text: "bury a friend", working_directory: "/home/owaiswiz/generated_images")
```
___
7. **output_file_name** (optional, *string*) - Specifies the name of the output file. By default its value is "output".
```ruby
KawaiiText::Generator.new(text: "bury a friend", output_file_name: "uncomfortable.png")
```
___
8. **primary_text_layer_config** (optional, *PrimaryTextLayerConfig*) - Configures the stroke size, stroke color and stroke fill color for the primary text layer.
```ruby
config = KawaiiText::PrimaryTextLayerConfig.new
config.pointsize = 72
config.stroke_width = 5
config.stroke_color = "#e24906"
config.stroke_fill_color = "#dc9f66"

KawaiiText::Generator.new(text: "Jokes", primary_text_layer_config: config)

```
***Output:***
![Custom Primary Text Layer Config](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/custom_primary_text_layer_config.png?raw=true "Custom Primary Text Layer Config")
___
9. **offset_text_layer_config** (optional, *OffsetTextLayerConfig*) - Configures the stroke size, stroke color and stroke fill color for the primary text layer.
```ruby
config = KawaiiText::OffsetTextLayerConfig.default
config.stroke_color = "#59C3C3"
config.stroke_fill_color = "#DCB6D5"
config.stroke_fill_color = "none"
config.stroke_width = 2
KawaiiText::Generator.new text: "bury a friend", offset_text_layer_config: config
```
***Output:***
![Custom Offset Text Layer Config](https://github.com/owaiswiz/kawaiitext/blob/master/examples/output/custom_offset_textlayer_config.png?raw=true "Custom Offset Text Layer Config")

### Dependencies
* Make sure you have ImageMagick installed.
* RMagick (should be automatically installed if not available)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/owaiswiz/kawaiitext.
