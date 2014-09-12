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
  def test_word_reversal()
   sentence          = "Reverse the words in this sentence but not the letters."
   expected_sentence = ".letters the not but sentence this in words the Reverse"
   actual_sentence   = reverse_sentence(sentence)

   # Assert 
   assert_equal(expected_sentence,actual_sentence)
  end
end

