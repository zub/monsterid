require 'oily_png'
require 'digest'
require 'color'

class MonsterID
  # Some info
  WHITE_PARTS = [
    'arms_1.png', 'arms_2.png', 'arms_S4.png', 'arms_S5.png',
    'eye_13.png', 'hair_1.png', 'hair_2.png', 'hair_3.png',
    'hair_5.png', 'legs_4.png', 'legs_S8.png', 'legs_S11.png',
    'mouth_5.png', 'mouth_8.png', 'mouth_S1.png', 'mouth_S3.png',
    'mouth_2.png'
  ]
  SAME_COLOR_PARTS = [
    'arms_S8.png', 'legs_S5.png', 'legs_S13.png',
    'mouth_S5.png', 'mouth_S4.png'
  ]
  SPECIFIC_COLOR_PARTS = { 'hair_S4.png'  => [0.6, 0.75],
                           'arms_S2.png'  => [-0.05, 0.05],
                           'hair_S6.png'  => [-0.05, 0.05],
                           'mouth_9.png'  => [-0.05, 0.05],
                           'mouth_6.png'  => [-0.05, 0.05],
                           'mouth_S2.png' => [-0.05, 0.05] }
  RANDOM_COLOR_PARTS = [
    'arms_3.png', 'arms_4.png', 'arms_5.png', 'arms_S1.png',
    'arms_S3.png', 'arms_S5.png', 'arms_S6.png', 'arms_S7.png',
    'arms_S9.png', 'hair_S1.png', 'hair_S2.png', 'hair_S3.png',
    'hair_S5.png', 'legs_1.png', 'legs_2.png', 'legs_3.png',
    'legs_5.png', 'legs_S1.png', 'legs_S2.png', 'legs_S3.png',
    'legs_S4.png', 'legs_S6.png', 'legs_S7.png', 'legs_S10.png',
    'legs_S12.png', 'mouth_3.png', 'mouth_4.png', 'mouth_7.png',
    'mouth_10.png', 'mouth_S6.png'
  ]
  
  PARTS = {
    :arms  => [
      "arms_1.png", "arms_2.png", "arms_3.png", "arms_4.png", "arms_5.png",
      "arms_S1.png", "arms_S2.png", "arms_S3.png", "arms_S4.png", "arms_S5.png",
      "arms_S6.png", "arms_S7.png", "arms_S8.png", "arms_S9.png"
    ],
    :body  => [
      "body_1.png", "body_2.png", "body_3.png", "body_4.png", "body_5.png",
      "body_6.png", "body_7.png", "body_8.png", "body_9.png", "body_10.png",
      "body_11.png", "body_12.png", "body_13.png", "body_14.png", "body_15.png",
      "body_S1.png", "body_S2.png", "body_S3.png", "body_S4.png", "body_S5.png"
    ],
    :eyes  => [
      "eyes_1.png", "eyes_2.png", "eyes_3.png", "eyes_4.png", "eyes_5.png",
      "eyes_6.png", "eyes_7.png", "eyes_8.png", "eyes_9.png", "eyes_10.png",
      "eyes_11.png", "eyes_12.png", "eyes_13.png", "eyes_14.png", "eyes_15.png",
      "eyes_S1.png", "eyes_S2.png", "eyes_S3.png", "eyes_S4.png", "eyes_S5.png"
    ],
    :hair  => [
      "hair_1.png", "hair_2.png", "hair_3.png", "hair_4.png", "hair_5.png",
      "hair_S1.png", "hair_S2.png", "hair_S3.png", "hair_S4.png", "hair_S5.png",
      "hair_S6.png", "hair_S7.png"
    ],
    :legs  => [
      "legs_1.png", "legs_2.png", "legs_3.png", "legs_4.png", "legs_5.png",
      "legs_S1.png", "legs_S10.png", "legs_S11.png", "legs_S12.png", "legs_S13.png",
      "legs_S2.png", "legs_S3.png", "legs_S4.png", "legs_S5.png", "legs_S6.png",
      "legs_S7.png", "legs_S8.png", "legs_S9.png"
    ],
    :mouth => [
      "mouth_1.png", "mouth_2.png", "mouth_3.png", "mouth_4.png", "mouth_5.png",
      "mouth_6.png", "mouth_7.png", "mouth_8.png", "mouth_9.png", "mouth_10.png",
      "mouth_S1.png", "mouth_S2.png", "mouth_S3.png", "mouth_S4.png", "mouth_S5.png",
      "mouth_S6.png", "mouth_S7.png"
    ]
  }
  
  # Test color set [hue, sat]
  COLORS = [
    [8, 255], [160, 64], [8, 127], [184, 255],
    [24, 191], [208, 191], [40, 255], [208, 64],
    [48, 64], [248, 191], [72, 127], [272, 64],
    [128, 255], [312, 191], [160, 255], [336, 255]
  ]
  
  def initialize(seed, size = 120)
    seed = Digest::SHA1.hexdigest seed.to_s
    
    parts = {
      :legs  => {
        :part => PARTS[:legs ][seed[0,2].hex % PARTS[:legs ].length],
        :color => COLORS[seed[2,2].hex % COLORS.length]
      },
      :hair  => {
        :part => PARTS[:hair ][seed[4,2].hex % PARTS[:hair ].length],
        :color => COLORS[seed[6,2].hex % COLORS.length]
      },
      :arms  => { 
        :part => PARTS[:arms ][seed[8,2].hex % PARTS[:arms ].length],
        :color => COLORS[seed[10,2].hex % COLORS.length]
      },
      :body  => {
        :part => PARTS[:body ][seed[12,2].hex % PARTS[:body ].length],
        :color => COLORS[seed[14,2].hex % COLORS.length]
      },
      :eyes  => {
        :part => PARTS[:eyes ][seed[16,2].hex % PARTS[:eyes ].length],
        :color => COLORS[seed[18,2].hex % COLORS.length]
      },
      :mouth => {
        :part => PARTS[:mouth][seed[20,2].hex % PARTS[:mouth].length],
        :color => COLORS[seed[22,2].hex % COLORS.length]
      }
    }
    
    monster = ChunkyPNG::Image.new( 120, 120, ChunkyPNG::Color::TRANSPARENT )
    
    parts.each do |_,part|
      path = File.join(File.dirname(__FILE__), 'parts', part[:part])
      partimg = ChunkyPNG::Image.from_file(path)
      
      if WHITE_PARTS.include? part[:part]
        print "White part #{part[:part]} detected!\n"
      else
        partimg = colorise( partimg, part[:color][0], part[:color][1] )
      end
      
      monster.compose!(partimg)
    end
    
    monster.save( "#{seed}.png" )
    
    
  end
  
private
  def colorise( img, hue, sat = 255 )
    img.pixels.map! do |px|
      pxrgb = Color::RGB.new(ChunkyPNG::Color.r(px),
                             ChunkyPNG::Color.g(px),
                             ChunkyPNG::Color.b(px))
      pxhsl = pxrgb.to_hsl
      pxhsl.saturation = sat
      pxhsl.hue = hue
      newrgb = pxhsl.to_rgb
      
      ChunkyPNG::Color.rgba( newrgb.red.to_i, newrgb.green.to_i, newrgb.blue.to_i, ChunkyPNG::Color.a(px) )
    end
    
    img
  end
end

MonsterID.new( "hassan" )
MonsterID.new( "hassa" )
MonsterID.new( "abc" )
MonsterID.new( "mujaff" )
MonsterID.new( "knutaldrin@gmail.com" )
MonsterID.new( "heo" )
MonsterID.new( "mujasadgdshjhj" )
MonsterID.new( "mujgsdhgsdf" )
MonsterID.new( "jaddaf" )