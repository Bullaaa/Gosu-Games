require 'gosu'

class PongWin < Gosu::Window
	attr_reader :blip
	attr_reader :score
	attr_reader :explosion

	def initialize width = 800, height = 600, fullscreen = false
		super
		margin = 20
		self.caption = "Pong by AmAn"
		@Palla = Rectangle.new(margin, margin)
		@last_y = margin
		@PallaC = Rectangle.new(self.width - Rectangle::WIDTH - margin, margin)
		@ball = Ball.new( 100, 100, { :x => 4, :y => 4 } )
		@score = [0,0]
		@counter = 0

	end

	def update

		close if button_down? Gosu::KbEscape
		#palla_move
		@ball.update

		if @ball.x <= 0
     	 	@ball.x = @Palla.right
    	 	score[1] += 1
    	 	@ball.v[:x] = 4
     	 #flash_side(:left)
     	# @explosion_sound.play
    	elsif @ball.right >= self.width
      		@ball.x = @PallaC.left
      		score[0] += 1
      		@ball.v[:x] = -4
      #flash_side(:right)
      #@explosion_sound.play
    	end

    	@ball.reflect_vertical if @ball.y < 0 || @ball.bottom > self.height
	end

	def draw
		@Palla.draw
		@PallaC.draw
		@ball.draw

	end


end

class Object
  attr_accessor :x
  attr_accessor :y
  attr_accessor :w
  attr_accessor :h

  def initialize(x, y, w, h)
    @x = x
    @y = y
    @w = w
    @h = h
  end

  def left
    x
  end

  def right
    x + w
  end

  def right=(r)
    self.x = r - w
  end

  def top
    y
  end

  def top=(t)
    self.y = t
  end

  def bottom
    y + h
  end

  def center_y
    y + h/2
  end

  def center_x
    x + x/2
  end

  def bottom=(b)
    self.y = b - h
  end

  def collide?(other)
    x_overlap = [0, [right, other.right].min - [left, other.left].max].max
    y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max
    x_overlap * y_overlap != 0
  end
end


class Rectangle < Object


  WIDTH = 12
  HEIGHT = 60

  def initialize x, y
    super x, y, WIDTH, HEIGHT 
  end

  def draw
    Gosu.draw_rect x, y, w, h, Gosu::Color.argb(0xff_ffffff)
  end
end

class Ball < Object
  WIDTH = 5
  HEIGHT = 5

  attr_reader :v
  def initialize(x, y, v)
    super(x, y, WIDTH, HEIGHT)
    @v = v
  end

  def update
    self.x += v[:x]
    self.y += v[:y]
  end

  def reflect_horizontal
    v[:x] = -v[:x]
  end

  def reflect_vertical
    v[:y] = -v[:y]
  end

  def draw
    Gosu.draw_rect x, y, WIDTH, HEIGHT, Gosu::Color::RED
  end
end

window = PongWin.new
window.show


PongWin.new.show
