require_relative "test_helper"

class RecordsRipTest < Minitest::Test
  def setup
    User.delete_all
    RecordsRip::Tomb.delete_all
  end

  def test_raise_a_tomb
    user = User.create!(name: 'John')
    user.destroy
    assert RecordsRip::Tomb.all.size == 1
  end
end
