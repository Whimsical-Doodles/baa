require 'test/unit'
require 'baa'

class BAATest < Test::Unit::TestCase
  include BAA::Hooks
  def test_hook
    assert_equal("hello", hook)
  end
end
