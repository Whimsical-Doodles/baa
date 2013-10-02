$: << 'lib'
require 'baa'
require 'pry'
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
  rescue Exception => e
    puts e.message
  end
end

Foo.new.bar
Foo.new.baz
Foo.new.blat
