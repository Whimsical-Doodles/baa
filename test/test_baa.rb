require 'test/unit'
require 'baa'
require 'bundler'
Bundler.require

class BAATest < Test::Unit::TestCase
  include BAA::Hooks
  def test_before
    binding.pry
    assert_equal(self.respond_to?(:before),true)
    assert_equal(self.send(:before),{})
  end

  def test_after
    assert_equal(self.respond_to?(:after),true)
    assert_equal(self.send(:after),{})
  end

  def test_around
    assert_equal(self.respond_to?(:around),true)
    assert_equal(self.send(:around),{})
  end
end
