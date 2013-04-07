require 'gosu'
require_relative 'lib/common'
require_relative 'lib/ship'
require_relative 'lib/player_ship'
require_relative 'lib/enemy_ship'
require_relative 'lib/laser_shot'

module SpaceShooter

  class GameWindow < Gosu::Window
    include Common

    def initialize
      super 640, 480, false
      self.caption = "Space Shooter Game"
      @background_image = Gosu::Image.new(self, "media/space.png", true)
      @enemy_speed = 0.5
      create_ship
      spawn_enemies
    end

    def create_ship
      @ship = PlayerShip.new(self)
      @ship.warp(320, 240)
    end

    def spawn_enemies
      Random.rand(0..10).times { enemies << EnemyShip.new(self, @enemy_speed) }
    end

    def update
      if button_down? Gosu::KbLeft
        @ship.turn_left
      end
      if button_down? Gosu::KbRight
        @ship.turn_right
      end
      if button_down? Gosu::KbUp
        @ship.accelerate
      end
      if button_down?(Gosu::KbSpace)
        if @ship.laser_ready
          @ship.fire_laser
          shots << LaserShot.new(self, @ship)
        end
      end
      shots.reject!{|shot| shot.dead? }
      enemies.reject!{|enemy| enemy.dead? }
      spawn_enemies if enemies.empty?
      detect_collisions
      enemies.each {|enemy| enemy.move }
      shots.each {|shot| shot.move}
      @ship.move
    end

    def detect_collisions
      shots.each do |shot| 
        enemies.each do |enemy| 
          if collision?(enemy, @ship)
            # subtract ship health
            enemy.register_hit
          end
          if collision?(shot, enemy)
            shot.kill
            enemy.register_hit
          end
        end
      end
    end

    def collision?(object_1, object_2)
      hitbox_1, hitbox_2 = object_1.hitbox, object_2.hitbox
      common_x = hitbox_1[:x] & hitbox_2[:x]
      common_y = hitbox_1[:y] & hitbox_2[:y]
      common_x.size > 0 && common_y.size > 0 
    end

    def draw
      @background_image.draw(0, 0, 0)
      enemies.each {|enemy| enemy.draw }
      shots.each {|shot| shot.draw }
      @ship.draw
    end

    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end

    private

    def shots
      @shots ||= []
    end

    def enemies
      @enemies ||= []
    end

  end

end

window = SpaceShooter::GameWindow.new
window.show
