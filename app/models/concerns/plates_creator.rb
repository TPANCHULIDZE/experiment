module PlatesCreator
  def parse_values
    @plate_size = convert(@plate_size)
    @samples = parse(@samples, 'samples')
    @reagents = parse(@reagents, 'reagents')
    @replicates = parse(@replicates, 'replicates')

    validate_values if @errors.empty?
    create_plate if @errors.empty?
  end

  def create_plate
    if(@plate_size == 96)
      @col = 12
      @row = 8
    else
      @col = 24
      @row = 16
    end

    fill_plate
  end

  def fill_plate
    generate_result
    
    @plate = Array.new(@col) { Array.new(@row) { nil }  }
    size = @result.size 
    index = 0
    col = 0
    row = 0;

    while(size > index)  
      element = @result[index]
      element[2].times do
        if(col < @col && row < @row)
          @plate[row][col] = [element[0], element[1]]
          col += 1
        elsif (row + 1 < @row)
          col = 0
          row += 1
          @plate[row][col] = [element[0], element[1]]
          col += 1
        else
          @plates << @plate
          col = 0
          row = 0
          @plate = Array.new(@col) { Array.new(@row) { nil }  }
        end
      end
      index += 1
    end
    @plates << @plate if @plate[0][0] != nil
  end
  
  def there_are_arrays_of_strings?(samples, reagents)
    samples.each do |sample|
      return false unless sample.is_a? String
    end

    reagents.each do |reagent|
      return false unless reagent.is_a? String
    end

    return true
  end

  def parse(values, name)
    return JSON.parse(values) if values.is_a? String

    return value
  rescue
    @errors << "invalid values of #{name}"
  end

  def convert(value)
    return value.to_i if value.is_a? String

    return value
  rescue
    @errors << "invalid plate size"
  end

  def generate_result
    @result = []

    @samples.each_with_index do |sample, sam_index|
      sample.each_with_index do |element, ele_index|
        @reagents[sam_index].each do |reagent|
          @result << [reagent, element, @replicates[sam_index]]
        end  
      end
    end

    @result.sort!
  end

  def assign_parameters(parameters)
    @errors = []
    @plates = []
    @plate_size = parameters[:plate_size] || nil
    @replicates = parameters[:replicates] || []
   
    samples = parameters[:samples] || ""
    reagents = parameters[:reagents] || ""
    @samples = samples.gsub(/\b([\w-]+)\b/, '"\1"')
    @reagents = reagents.gsub(/\b([\w-]+)\b/, '"\1"')
  end


  def validate_values
    if @samples.size != @reagents.size || @reagents.size != @replicates.size || (@plate_size != 96 && @plate_size != 384) 
      @errors << "there is not valid information"
    else
      @samples.each_with_index do |sample, index|
        unless there_are_arrays_of_strings?(sample, @reagents[index]) && (@replicates[index].is_a? Integer)
          @errors << "there is not valid information"
        end
      end
    end
  end
end