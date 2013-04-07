module SpaceShooter

  class Ship
    include Common

    attr_accessor :x, :y, :angle, :health

    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end

    def register_hit
      subtract_health 5
      case health
      when 75..100 then
        @speed_modifier = 0.4
        @image.insert('media/enemy-damage-1.png', 0, 0)
      when 50..75 then
        @speed_modifier = 0.3
        @image.insert('media/enemy-damage-2.png', 0, 0)
      when 0..50 then
        @speed_modifier = 0.1
        @image.insert('media/enemy-damage-3.png', 0, 0)
      end
    end

    def dead?
      health_left <= 0
    end

    def health_left
      @health ||= 100
    end

    def subtract_health amount
      health_left
      @health -= amount
    end

    def fire_laser
      @shot_fired_at = Time.now
    end

    def laser_ready
      (Time.now - shot_fired_at).to_i >= 0.5
    end

    def shot_fired_at
      @shot_fired_at ||= Time.now
    end

  end

end