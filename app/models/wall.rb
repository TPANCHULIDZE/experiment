class Wall
  include PlatesCreator
  
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

