baa
====

Before After Around hooks for Ruby classes

```bash
  gem install baa
```

```ruby

require 'baa'

class Foo
  extend Hooks

  def bar
    puts 'bar'
  end

  def baz
    puts 'baz'
  end

  def blat
    puts 'blat'
  end

  before :bar do
    puts 'before bar'
  end

  def pre
    puts 'before baz'
  end

  around :baz, :pre do
    puts 'after baz'
  end

  after :blat do
    puts 'after blat'
  end

  begin
    before :baz do
      puts "this should error"
    end
  rescue StandardError => e
    puts e.message
  end
end

Foo.new.bar
Foo.new.baz
Foo.new.blat

```

outputs

```bash
  Method (:baz) already has hooks applied
  {:before=>[:bar], :after=>[:blat], :around=>[:baz]}
  before bar
  bar
  before baz
  baz
  after baz
  blat
  after blat
```
