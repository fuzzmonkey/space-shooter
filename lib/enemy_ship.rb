module SpaceShooter

  class EnemyShip < Ship
    include Common

    def initialize(window, speed_modifier)
      @image = Gosu::Image.new(window, 'media/enemy.png', false)
      @x, @y, @angle = rand(640), rand(240), rand(360)
      @speed_modifier = speed_modifier
    end

    def move
      @x += Gosu::offset_x(@angle, @speed_modifier)
      @y += Gosu::offset_y(@angle, @speed_modifier)
      @x %= 640
      @y %= 480
    end

  end

end