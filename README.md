MonsterID
================

A port of the php script by Andreas Gohr (http://www.splitbrain.org/projects/monsterid).
Actually kinda more like a rewrite.

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


Copyright (c) 2014 Knut Aldrin Wikström. See LICENSE for
further details.

