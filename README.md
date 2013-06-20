BabaScript
==========
BabaScript is a script language which runs on @takumibaba


Installation
------------

    % gem install babascript


Usage
-----

```ruby
require 'rubygems'
require 'babascript'

BabaScript.baba do
  起きてください
end
```

```ruby
BabaScript.baba do
  アイス買ってきてよ("#{rand(10)}本")
end
```


Contributing
------------
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
