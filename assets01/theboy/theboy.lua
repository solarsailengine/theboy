local script = require('scriptcomponent'):derive()

-- Constants
local MOVE_SPEED = 3.0
local JUMP_VELOCITY = 8.0
local GRAVITY = -20.0
local GROUND_Y = 0.0

function script:on_init()
	-- Cache input button IDs
	self.space_button = Input.getbuttonidforname("SPACE")
	self.left_button = Input.getbuttonidforname("LEFT")
	self.right_button = Input.getbuttonidforname("RIGHT")
	self.up_button = Input.getbuttonidforname("UP")
	self.down_button = Input.getbuttonidforname("DOWN")
	
	-- Number key bindings for animations
	self.key_1 = Input.getbuttonidforname("1")
	self.key_2 = Input.getbuttonidforname("2")
	self.key_3 = Input.getbuttonidforname("3")
	self.key_4 = Input.getbuttonidforname("4")
	self.key_5 = Input.getbuttonidforname("5")
	self.key_0 = Input.getbuttonidforname("0")
	
	-- Initialize state
	self.velocity_y = 0
	self.on_ground = true
	self.facing_right = true
	self.manual_animation = false  -- Track if user manually set animation

end

function script:on_update()
	local dt = Time.deltaTime
	local transform = getComponent(self.entity, "transform")
	local animated_sprite = getComponent(self.entity, "animatedsprite")
	
	if not transform or not animated_sprite then return end
	
	-- Reset manual animation flag after a delay
	if self.manual_animation then
		if not self.manual_animation_timer then
			self.manual_animation_timer = 0
		end
		self.manual_animation_timer = self.manual_animation_timer + dt
		if self.manual_animation_timer > 2.0 then  -- Reset after 2 seconds
			self.manual_animation = false
			self.manual_animation_timer = nil
		end
	end
	
	-- Handle animation selection with number keys
	if Input.getbutton(self.key_1) == Input.JUSTPRESSED then
		animated_sprite.name = 'TheBoy/idle'
		self.manual_animation = true
		self.manual_animation_timer = 0
	elseif Input.getbutton(self.key_2) == Input.JUSTPRESSED then
		animated_sprite.name = 'TheBoy/walk'
		self.manual_animation = true
		self.manual_animation_timer = 0
	elseif Input.getbutton(self.key_3) == Input.JUSTPRESSED then
		animated_sprite.name = 'TheBoy/run'
		self.manual_animation = true
		self.manual_animation_timer = 0
	elseif Input.getbutton(self.key_4) == Input.JUSTPRESSED then
		animated_sprite.name = 'TheBoy/jump'
		self.manual_animation = true
		self.manual_animation_timer = 0
	elseif Input.getbutton(self.key_5) == Input.JUSTPRESSED then
		animated_sprite.name = 'TheBoy/dead'
		self.manual_animation = true
		self.manual_animation_timer = 0
	elseif Input.getbutton(self.key_0) == Input.JUSTPRESSED then
		-- Reset to automatic animation mode
		self.manual_animation = false
		self.manual_animation_timer = nil
	end
	
	-- Handle movement
	local moving = false
	local move_x = 0
	
	-- Check if buttons are pressed (returns > 0 when pressed)
	local left_pressed = Input.getbutton(self.left_button) > 0
	local right_pressed = Input.getbutton(self.right_button) > 0
	
	if left_pressed then
		move_x = -MOVE_SPEED * dt
		moving = true
		
		-- Face left
		if self.facing_right then
			self.facing_right = false
			transform.scale = vec3(-1.0, 1.0, 1.0)
		end
	elseif right_pressed then
		move_x = MOVE_SPEED * dt
		moving = true
		
		-- Face right
		if not self.facing_right then
			self.facing_right = true
			transform.scale = vec3(1.0, 1.0, 1.0)
		end
	end
	
	-- Apply horizontal movement
	local pos = transform.translation
	pos.x = pos.x + move_x
	
	-- Handle jump (check for just pressed - value 2)
	if Input.getbutton(self.space_button) == 2 and self.on_ground then
		self.velocity_y = JUMP_VELOCITY
		self.on_ground = false
		animated_sprite.name = 'TheBoy/jump'
	end
	
	-- Apply gravity
	if not self.on_ground then
		self.velocity_y = self.velocity_y + GRAVITY * dt
		pos.y = pos.y + self.velocity_y * dt
		
		-- Check ground collision
		if pos.y <= GROUND_Y then
			pos.y = GROUND_Y
			self.velocity_y = 0
			self.on_ground = true
		end
	end
	
	-- Update animation based on state (only if not manually set)
	if not self.manual_animation then
		if self.on_ground and not moving then
			if animated_sprite.name ~= 'TheBoy/idle' and animated_sprite.name ~= 'TheBoy/dead' then
				animated_sprite.name = 'TheBoy/idle'
			end
		elseif self.on_ground and moving then
			if animated_sprite.name ~= 'TheBoy/run' and animated_sprite.name ~= 'TheBoy/walk' then
				animated_sprite.name = 'TheBoy/run'
			end
		end
	end
	
	-- Update position
	transform.translation = pos
end

return script
