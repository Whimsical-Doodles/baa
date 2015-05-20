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
  rescue Exception => e
    puts e.message
  end
end

describe Foo do
  let(:foo) { described_class.new }

  it 'response with in the correct order' do
    expect($stdout).to receive(:puts).with("before bar")
    expect($stdout).to receive(:puts).with("bar")
    foo.bar

    expect($stdout).to receive(:puts).with("before baz")
    expect($stdout).to receive(:puts).with('baz')
    expect($stdout).to receive(:puts).with("after baz")
    foo.baz

    expect($stdout).to receive(:puts).with('blat')
    expect($stdout).to receive(:puts).with("after blat")
    foo.blat
  end
end
