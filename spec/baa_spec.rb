# frozen_string_literal: true

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
end

describe Foo do
  let(:foo) { described_class.new }

  it 'has inserted a before bar' do
    expect($stdout).to receive(:puts).with('before bar')
    expect($stdout).to receive(:puts).with('bar')
    foo.bar
  end

  it 'has inserted an around baz' do
    expect($stdout).to receive(:puts).with('before baz')
    expect($stdout).to receive(:puts).with('baz')
    expect($stdout).to receive(:puts).with('after baz')
    foo.baz
  end

  it 'has inserted an after blat' do
    expect($stdout).to receive(:puts).with('blat')
    expect($stdout).to receive(:puts).with('after blat')
    foo.blat
  end
end

class FooWithError
  extend Hooks

  def bar
    puts 'bar'
  end

  before :bar do
    puts 'before bar'
  end

  def self.add_hook
    before :bar do
      puts 'this should error'
    end
  end
end

describe FooWithError do
  it 'raises an error on second hook definition' do
    expect { described_class.add_hook }.to raise_error(HookExistsError)
  end
end
