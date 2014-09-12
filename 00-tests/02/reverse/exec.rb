#!/opt/apps/ruby/ruby/bin/ruby

def reverse_sentence(sentence)
  period = '.'
  sentence = sentence.strip.chomp(period)
  s_ary    = sentence.split(/\s/).reverse
  reverse = period + s_ary.join(" ")
  return reverse
end

sentence = "Reverse the words in this sentence but not the letters."
puts reverse_sentence(sentence)
