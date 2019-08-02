def yield_name(name)
  puts "In the method! Let's yield."
  yield name
  puts "Block complete! Back in the method."
end

yield_name("Eric") { |name| puts "My name is #{name}." }

# Now call the method with your name!
yield_name("jared"){|m| puts "ok"}