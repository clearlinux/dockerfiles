def block_test
  puts "We're in the method!"
  puts "Yielding to the block..."
  yield
  yield
  puts "We're back in the method!"
end

block_test { puts ">>>>>>>>>> We're in the block!" }

block_test { puts "below it?!?>>>>>>>>>>>>"}