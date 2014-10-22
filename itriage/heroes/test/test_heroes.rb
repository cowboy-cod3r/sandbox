# == DESCRIPTION
# Performs Tests
#
# == ASSERTIONS
# Testing is performed by minitest.  You can find assertions here:
#   * http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Assertions.html


# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),"..","lib"))

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'itriage/heroes'
require 'benchmark'

# Module Includes
include MiniTest::Assertions

class TestHeroes < MiniTest::Unit::TestCase

  attr_accessor :heroes, :dummy_record, :valid_record

  # ==== Description
  # Setup the scenario
  def setup
    # Get a heroes object
    @heroes       = Itriage::Heroes.new(false,'heroes-api.herokuapp.com',80)
    @dummy_record = {"id" => 9,  "name"=>"Homey", "realName"=>"Sean Humbarger", "owner"=>"My Wife", "gender"=>"male"}
    @valid_record = {"id"=>1, "name"=>"Iron Man", "realName"=>"Tony Stark", "owner"=>"Marvel", "gender"=>"male"}
    @max_api_time = 0.2
  end

  # ==== Description
  # Tear it all down, put it back to a good state
  def teardown
    @heroes.delete_hero(@dummy_record)
  end

  # ==== Description
  # Verify the heroes api was constructed properly
  def test_heroes_url()
    expected_url = 'http://heroes-api.herokuapp.com:80/api/heroes'

    # Perform assertion
    assert_equal(expected_url, @heroes.heroes_api)
  end

  # ==== Description
  # Retrieve all heroes
  def test_retrieve_and_count_all_heroes()
    expected_count = 8

    # Perform assertion
    assert_equal(expected_count, @heroes.get_heroes().size)
  end

  # ==== Description
  # Retrieve all heroes
  def test_verify_all_fields_record()
    expected_fields = ['id', 'name', 'realName', 'owner', 'gender']

    # Grab the first record
    record = @heroes.get_heroes[0]

    # Perform assertion
    assert_equal(record.keys.sort, expected_fields.sort)
  end

  # ==== Description
  # Retrieve a valid record
  def test_retrieve_a_valid_record_by_id()
    # Grab the first record
    record = @heroes.get_hero(1)

    # Perform assertion
    assert_equal(@valid_record, record)
  end

  # ==== Description
  # Post a new record
  def test_verify_record_exists()
    exists = @heroes.hero_exists?('Iron Man', 'Tony Stark')
    assert_equal(true, exists)
  end

  # ==== Description
  # Post a dummy record
  def test_post_record()
    @heroes.post_hero(@dummy_record)

    # Does the hero exist?
    exists = @heroes.hero_exists?(@dummy_record['name'], @dummy_record['realName'])
    assert_equal(true, exists)
  end

  # ==== Description
  # Delete the dummy record
  def test_delete_record()
    exists = @heroes.hero_exists?(@dummy_record['name'], @dummy_record['realName']
    if exists
      @heroes.delete_hero(@dummy_record)

      # Does the hero exist?
      assert_equal(false, exists)
    else
      puts "the record didn't exist"
    end
  end

  # ==== Description
  # Verify get heroes returns in less than 200 milliseconds
  def test_perf_get_heroes()
    time = Benchmark.realtime do |bm|
      @heroes.get_heroes
    end
    assert_operator time, :<=, @max_api_time
  end

  # ==== Description
  # Verify get heroes returns in less than 200 milliseconds
  def test_perf_get_hero()
    time = Benchmark.realtime do |bm|
      @heroes.get_hero(@valid_record['id'])
    end
    assert_operator time, :<=, @max_api_time
  end

  # ==== Description
  # Verify post hero returns in less than 200 milliseconds
  def test_perf_post_hero()
    time = Benchmark.realtime do |bm|
      @heroes.post_hero(@dummy_record)
    end
    assert_operator time, :<=, @max_api_time
  end

  # ==== Description
  # Verify post hero returns in less than 200 milliseconds
  def test_perf_delete_hero()
    time = Benchmark.realtime do |bm|
      @heroes.delete_hero(@dummy_record)
    end
    assert_operator time, :<=, @max_api_time
  end
end

