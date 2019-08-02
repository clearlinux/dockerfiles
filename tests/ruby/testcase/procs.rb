# Here at the amusement park, you have to be four feet tall
# or taller to ride the roller coaster. Let's use .select on
# each group to get only the ones four feet tall or taller.

group_1 = [4.1, 5.5, 3.2, 3.3, 6.1, 3.9, 4.7]
group_2 = [7.0, 3.8, 6.2, 6.1, 4.4, 4.9, 3.0]
group_3 = [5.5, 5.1, 3.9, 4.3, 4.9, 3.2, 3.2]


over_4_feet = Proc.new { |x| x >= 4 }


print "group 1:  #{group_1.select(&over_4_feet)}"
puts
print "group 2: #{group_2.select(&over_4_feet)}"
puts
print "group 3: #{group_3.select(&over_4_feet)}"

