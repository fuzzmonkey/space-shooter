module SpaceShooter

  class PlayerShip < Ship
    include Common

    def initialize(window)
      @image = Gosu::Image.new(window, "media/ship.png", false)
      @window = window
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @score = 0
    end

    def move
      @x += @vel_x
      @y += @vel_y
      @x %= 640
      @y %= 480

      @vel_x *= 0.95
      @vel_y *= 0.95
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def turn_left
      @angle -= 4.5
    end

    def turn_right
      @angle += 4.5
    end

    def accelerate
      @vel_x += Gosu::offset_x(@angle, 0.25)
      @vel_y += Gosu::offset_y(@angle, 0.25)
    end

  end
end