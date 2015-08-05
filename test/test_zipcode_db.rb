require 'minitest/autorun'
require 'zipcode-db'

class ZipCode::Mock1
  # rubocop:disable Metrics/MethodLength
  def search(key, value)
    [
      {
        name: 'PARIS',
        zip:  '75000',
      },
      {
        name: 'PALAISEAU',
        zip:  '91120',
      },
      {
        name: 'BORDEAUX',
        zip:  '33000',
      },
      {
        name: 'CHERBOURG',
        zip:  '50100',
      },
      {
        name: 'BERLANCOURT',
        zip:  '02250',
      },
    ].select { |e| e[key] =~ /\b#{value}/i }
  end
end

class ZipCode::Mock2
  def search(key, value)
    [
      {
        name: 'BERLIN',
        zip:  '10115',
      },
      {
        name: 'FRANKFURT',
        zip:  '60001',
      },
      {
        name: 'KEHL',
        zip:  '77671',
      },
    ].select { |e| e[key] =~ /\b#{value}/i }
  end
end

class TestZipCodeDB < MiniTest::Test
  def setup
    ZipCode::DB.register(:mock1, @mock1 = ZipCode::Mock1.new)
    ZipCode::DB.register(:mock2, @mock2 = ZipCode::Mock2.new)
  end

  def teardown
    ZipCode::DB.instance_eval do
      @default = nil
      @registry = nil
    end
  end

  def test_registry
    assert_equal(@mock1, ZipCode::DB.for(:mock1))
    assert_equal(@mock2, ZipCode::DB.for(:mock2))
  end

  def test_query
    result1 = ZipCode::DB.for(:mock1).search(:name, 'PAR')
    assert_equal(1, result1.count)
    assert_equal('PARIS', result1.first[:name])

    result2 = ZipCode::DB.for(:mock2).search(:name, 'FRA')
    assert_equal(1, result2.count)
    assert_equal('FRANKFURT', result2.first[:name])
  end

  def test_query_with_key_as_string
    result1 = ZipCode::DB.for(:mock1).search('name', 'PAR')
    assert_equal(1, result1.count)
    assert_equal('PARIS', result1.first[:name])
  end

  def test_intersecting_query
    result1 = ZipCode::DB.for(:mock1).search(:name, 'BER')
    assert_equal(1, result1.count)
    assert_equal('BERLANCOURT', result1.first[:name])

    result2 = ZipCode::DB.for(:mock2).search(:name, 'BER')
    assert_equal(1, result2.count)
    assert_equal('BERLIN', result2.first[:name])
  end
end
