def lambda_demo(a_lambda)
  puts "I'm the method!"
  a_lambda.call
end

lambda_demo(lambda { puts "I'm the lambda!" })


def jared(werba)
    puts "still unsure"
    werba.call
end

jared(lambda {puts "why is werba.call inside of the method?"})
jared(lambda {puts "will this work?!!?!?!!"})