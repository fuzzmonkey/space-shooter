module SpaceShooter

  class LaserShot
    include Common

    def initialize(window, origin_object)
      @x, @y = origin_object.x, origin_object.y
      @angle = origin_object.angle
      @speed_modifier = 7
      @image = Gosu::Image.new(window, 'media/laser_shot.png', false)
      @distance_traveled, @max_distance = 0, 25
      @alive = true
    end

    def kill
      @alive = false
    end

    def dead?
      !@alive
    end

    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end

    def move
      @distance_traveled += 1
      kill if @distance_traveled > @max_distance
      @x += Gosu::offset_x(@angle, @speed_modifier)
      @y += Gosu::offset_y(@angle, @speed_modifier)
      @x %= 640
      @y %= 480
    end

  end

end