require_relative "test_helper"

class RecordsRipTest < Minitest::Test
  def setup
    User.delete_all
    Member.delete_all
    RecordsRip::Tomb.delete_all
  end

  def test_raise_a_tomb
    user = User.create!(name: 'John')
    user.destroy
    assert RecordsRip::Tomb.all.size == 1
  end

  def test_model_class_tomb
    user = User.create!(name: 'John')
    user.destroy
    assert User.tomb(name: 'John').size == 1
  end

  def test_tomb_class_where_epitaph
    user = User.create!(name: 'John')
    user.destroy
    assert ::RecordsRip::Tomb.where_epitaph(name: 'John').size == 1
  end

  def test_block_given
    member = Member.create!(name: 'John')
    member.destroy
    assert ::RecordsRip::Tomb.where_epitaph(name: 'Great John').size == 1
  end
end
