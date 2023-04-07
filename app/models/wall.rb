class Wall
  include PlatesCreator # ./concerns/plates_creator.rb
  
  def initialize(parameters = {})   
    assign_parameters(parameters)
    parse_values
  end

  def width
    @col
  end

  def errors
    @errors
  end

  def height
    @row
  end

  def plates
    @plates
  end
end

