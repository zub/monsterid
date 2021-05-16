# frozen_string_literal: true

# Load oily_png if available, otherwise default to pure ruby chunky_png
begin
  require 'oily_png'
rescue LoadError
  require 'chunky_png'
end

require 'digest'

# Generates cute monsters from a seed
class MonsterID
  WHITE_PARTS = [
    'arms_1.png', 'arms_2.png', 'arms_S4.png', 'eye_13.png',
    'hair_1.png', 'hair_2.png', 'hair_3.png', 'hair_5.png',
    'legs_4.png', 'legs_S8.png', 'legs_S11.png', 'mouth_5.png',
    'mouth_8.png', 'mouth_S1.png', 'mouth_S3.png', 'mouth_2.png',
    'eyes_13.png', 'legs_S13.png', 'mouth_S7.png'
  ].freeze
  BODY_COLOR_PARTS = [
    'arms_S8.png', 'legs_S5.png',
    'mouth_S5.png', 'mouth_S4.png'
  ].freeze
  SPECIFIC_COLOR_PARTS = {
    'arms_S2.png' => [0, 200],
    'hair_S6.png' => [0, 200],
    'mouth_9.png' => [0, 200],
    'mouth_6.png' => [0, 200],
    'mouth_S2.png' => [0, 200]
  }.freeze

  PARTS = {
    arms: [
      'arms_1.png', 'arms_2.png', 'arms_3.png', 'arms_4.png', 'arms_5.png',
      'arms_S1.png', 'arms_S2.png', 'arms_S3.png', 'arms_S4.png', 'arms_S5.png',
      'arms_S6.png', 'arms_S7.png', 'arms_S8.png', 'arms_S9.png'
    ],
    body: [
      'body_1.png', 'body_2.png', 'body_3.png', 'body_4.png', 'body_5.png',
      'body_6.png', 'body_7.png', 'body_8.png', 'body_9.png', 'body_10.png',
      'body_11.png', 'body_12.png', 'body_13.png', 'body_14.png', 'body_15.png',
      'body_S1.png', 'body_S2.png', 'body_S3.png', 'body_S4.png', 'body_S5.png'
    ],
    eyes: [
      'eyes_1.png', 'eyes_2.png', 'eyes_3.png', 'eyes_4.png', 'eyes_5.png',
      'eyes_6.png', 'eyes_7.png', 'eyes_8.png', 'eyes_9.png', 'eyes_10.png',
      'eyes_11.png', 'eyes_12.png', 'eyes_13.png', 'eyes_14.png', 'eyes_15.png',
      'eyes_S1.png', 'eyes_S2.png', 'eyes_S3.png', 'eyes_S4.png', 'eyes_S5.png'
    ],
    hair: [
      'hair_1.png', 'hair_2.png', 'hair_3.png', 'hair_4.png', 'hair_5.png',
      'hair_S1.png', 'hair_S2.png', 'hair_S3.png', 'hair_S4.png', 'hair_S5.png',
      'hair_S6.png', 'hair_S7.png'
    ],
    legs: [
      'legs_1.png', 'legs_2.png', 'legs_3.png', 'legs_4.png', 'legs_5.png',
      'legs_S1.png', 'legs_S10.png', 'legs_S11.png', 'legs_S12.png',
      'legs_S13.png', 'legs_S2.png', 'legs_S3.png', 'legs_S4.png',
      'legs_S5.png', 'legs_S6.png', 'legs_S7.png', 'legs_S8.png', 'legs_S9.png'
    ],
    mouth: [
      'mouth_1.png', 'mouth_2.png', 'mouth_3.png', 'mouth_4.png', 'mouth_5.png',
      'mouth_6.png', 'mouth_7.png', 'mouth_8.png', 'mouth_9.png', 'mouth_10.png',
      'mouth_S1.png', 'mouth_S2.png', 'mouth_S3.png', 'mouth_S4.png', 'mouth_S5.png',
      'mouth_S6.png', 'mouth_S7.png'
    ]
  }.freeze

  # Remove body 12 for now, doesn't look good
  PARTS[:body].delete('body_12.png')

  # Test color set [hue, sat]
  COLORS = [
    [8, 255], [160, 64], [8, 127], [184, 255],
    [24, 191], [208, 191], [40, 255], [208, 64],
    [48, 64], [248, 191], [72, 127], [272, 64],
    [128, 255], [312, 191], [160, 255], [336, 255]
  ].freeze

  def initialize(seed, size = 120)
    @id = Digest::SHA1.hexdigest seed.to_s

    parts = {
      legs: {
        part: PARTS[:legs][@id[0, 2].hex % PARTS[:legs].length],
        color: COLORS[@id[2, 2].hex % COLORS.length]
      },
      hair: {
        part: PARTS[:hair][@id[4, 2].hex % PARTS[:hair].length],
        color: COLORS[@id[6, 2].hex % COLORS.length]
      },
      arms: {
        part: PARTS[:arms][@id[8, 2].hex % PARTS[:arms].length],
        color: COLORS[@id[10, 2].hex % COLORS.length]
      },
      body: {
        part: PARTS[:body][@id[12, 2].hex % PARTS[:body].length],
        color: COLORS[@id[14, 2].hex % COLORS.length]
      },
      eyes: {
        part: PARTS[:eyes][@id[16, 2].hex % PARTS[:eyes].length],
        color: COLORS[@id[18, 2].hex % COLORS.length]
      },
      mouth: {
        part: PARTS[:mouth][@id[20, 2].hex % PARTS[:mouth].length],
        color: COLORS[@id[22, 2].hex % COLORS.length]
      }
    }

    @monster = ChunkyPNG::Image.new(120, 120, ChunkyPNG::Color::TRANSPARENT)

    parts.each do |_, part|
      path = File.join(File.dirname(__FILE__), 'parts', part[:part])
      partimg = ChunkyPNG::Image.from_file(path)

      if BODY_COLOR_PARTS.include? part[:part]
        part[:color] = parts[:body][:color]
      elsif SPECIFIC_COLOR_PARTS.include? part[:part]
        part[:color] = SPECIFIC_COLOR_PARTS[part[:part]]
      end

      partimg = colorise(partimg, part[:color][0], part[:color][1]) unless WHITE_PARTS.include? part[:part]

      @monster.compose!(partimg)
    end

    resize(size) unless size == 120
  end

  def resize(size)
    @monster.resample_bilinear!(size, size)
  end

  def save(path)
    @monster.save path
  end

  def to_datastream
    @monster.to_datastream
  end

  attr_reader :id

  def to_data_url
    @monster.to_data_url
  end

  def inspect
    "#<#{self.class.name}:#{object_id} id: #{@id}>"
  end

  private

  def colorise(img, h, s = 255)
    s = s.to_f / 255 # ChunkyPNG uses sat from 0.0 to 1.0

    img.pixels.map! do |px|
      _, _, v, a = ChunkyPNG::Color.to_hsv(px, true)
      ChunkyPNG::Color.from_hsv(h, s, v, a)
    end

    img
  end
end
