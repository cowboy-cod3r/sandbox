# == DESCRIPTION
# Performs Tests
#
# == ASSERTIONS
# Testing is performed by minitest.  You can find assertions here:
#   * http://www.ruby-doc.org/stdlib-1.9.3/libdoc/minitest/unit/rdoc/MiniTest/Assertions.html


# Set Classpath
$:.unshift(File.join(File.dirname(__FILE__),".."))

# Required Libraries (Any utilities as well as the files to test)
require 'minitest/autorun'
require 'exec'

# Module Includes
include MiniTest::Assertions

class TestReverse < MiniTest::Unit::TestCase

  # ==== Description
  # Test
  def test_reverse_and_letters_easy()
    expected_sentence = ".srettel eht htiw gnola ecnetnes siht esreveR"
    actual_sentence   = reverse_words_and_letters("Reverse this sentence along with the letters.")
    assert_equal(expected_sentence, actual_sentence)
  end
end

