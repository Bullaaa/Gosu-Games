require 'gosu'


class Wwin < Gosu::Window
	def initialize
		super 800, 800, false


		self.caption = "Blood Rain by Bullaaa"

		@ranx = rand(self.width)
		@y = -self.height
		@velocity = 0.5
		#@background = Gosu::Image.new self, "background.png"
		#@background = Gosu::Image.new self, Gosu::Color.argb(0xff_ffffff)
		#@rain = Rectangle.new(@ranx, @y)
		@rains = Array.new(500)
		flash = {}
	end


	def update

		
		close if button_down? Gosu::KbEscape
		
		
	end


	def draw
		#draw_line(x-size, y-size, 0xff00ffff, x+size, y+size, 0xff00ffff)
		#for i in @rains
			#@ranx = rand(self.width)
		#	@rain = Rectangle.new(@ranx, @y)
		#	puts @ranx
		#	@rain.draw
		#end
 		#@rain.draw
 		Gosu.draw_rect 0, 0, self.width, self.height, Gosu::Color::WHITE
 		#@background.draw 0, 0, 0
 		fall

 	end


 	def fall
 		@rains.each do |rain|
 			rain = Rectangle.new(@ranx, @y)
 			rain.draw
 			#@ranx = rand(self.width)
 			@yspeed = 2
 			@y += (@yspeed * @velocity)
 			if @y == self.height
				@y = -self.height
			end
			@ranx = rand(self.width)
 		end
 		#flash(:left)
		#flash(:right)
 	end


 	def flash(side)
 		@flash[side] = true
 	end

end


class GameObject
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

end





class Rectangle < GameObject


  WIDTH = 3
  HEIGHT = rand(10..30)

  def initialize x, y
    super x, y, WIDTH, HEIGHT 
  end

  def draw
    Gosu.draw_rect x, y, w, h, Gosu::Color.argb(0xff_ff0000)
  end
end




Wwin.new.show
