MonsterID
================

A port of the php script by Andreas Gohr (http://www.splitbrain.org/projects/monsterid).
Actually kinda more like a rewrite.

After version 0.4 only ChunkyPNG is required, thus MonsterID now only requires pure ruby. :)
If OilyPNG is available, MonsterID will load it, and be as fast as before. Make sure OilyPNG is at least v1.2.1, as <=1.2.0 has a bug with transparency.

Feel free to use/steal/share/improve.

USAGE
=====

```ruby
require 'monsterid'

monster = MonsterID.new('email@somewhere.com')
print monster.id # SHA1 of seed
monster.save("~/monsters/#{monster.id}.png") # monster
print monster.to_datastream # Prints raw PNG
```


Copyright (c) 2014-2017 Knut Aldrin. See LICENSE for
further details.

