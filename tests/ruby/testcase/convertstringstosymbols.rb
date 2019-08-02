strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]

# Add your code below!
symbols = []
strings.each { |x| symbols.push(x.to_sym) }

puts symbols

