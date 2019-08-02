class Person
    attr_accessor :name

    def greeting
        "Hello #{@name}"
    end
end

person = Person.new
person.name = "Dennis"
puts person.greeting # => "Hello Dennis"
