text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus a nisl quis orci mattis vestibulum nec a orci. Sed sit amet libero vel purus tincidunt dictum. Curabitur sit amet quam justo. Nam rutrum tortor a tempor semper. Vivamus rhoncus commodo tortor vel vehicula. Fusce lobortis massa arcu, a ornare metus consequat ac. Nam urna est, vulputate a libero nec, accumsan convallis felis. Cras feugiat arcu tortor, malesuada ultrices arcu pretium a
"""
puts "Word to redact: "
redact = gets.chomp

words = text.split(" ")

words.each do |word|
  if word != redact
    print word + " "
  else
    print "REDACTED "
  end
end
