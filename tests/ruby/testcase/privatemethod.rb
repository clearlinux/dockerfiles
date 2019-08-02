class Application
  attr_accessor :status
  def initialize; end
private
def password
    @password = 12345
    end
    
    public
  def print_status
      puts "All systems go!"
  end
end

app = Application.new()
app.print_status()
app.password
