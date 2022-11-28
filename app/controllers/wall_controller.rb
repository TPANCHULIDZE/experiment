class WallController < ApplicationController
  def index 
    @wall ||= Wall.new()
  end

  def create
    @wall = Wall.new(wall_params)

    if @wall.errors.empty?
      @plates = @wall.plates
      @width = @wall.width
      @height = @wall.height
    else
      @errors = @wall.errors
    end
    render :index
  end

  private

  def wall_params
    params.require(:wall).permit(:plate_size, :samples, :reagents, :replicates) 
  end
end
