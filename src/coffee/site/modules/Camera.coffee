define ->

	class Camera

		angle: 0

		# where the camera is facing
		facing:
			x: 0
			y: 0
			z: 0

		# the camera's target position
		anchor:
			x: 9
			y: -6
			z: 9

		# the camera's actual position
		position:
			x: 0
			y: 0
			z: 0

		init: ->

			@.helpers()
			@.build()
			@.addListeners()

		helpers: ->

			Math.radians = ( n ) ->
				return n * ( Math.PI / 180 )

			Math.degrees = ( n ) ->
				return n * ( 180 / Math.PI )

		build: ->

			# store the camera in the alpha property
			@.alpha = new THREE.PerspectiveCamera 66 , window.innerWidth / window.innerHeight , 1 , 15000

		addListeners: ->

			# listen for a resize to update the camera
			window.addEventListener "resize" , @.onResize

		onResize: =>

			# update the apsect ratio and camera
			@.alpha.aspect = window.innerWidth / window.innerHeight
			@.alpha.updateProjectionMatrix()

		loop: =>

			@.getTargetPosition()
			@.updatePosition()
			@.rotate()

		getTargetPosition: ->

			# position the camera relative to the anchor
			# based on the angle + distance
			x = @.anchor.x
			y = @.anchor.y
			z = @.anchor.z
			@.position =
				x: x , y: y , z: z

		rotate: ->
			@.angle += 0.01
			@.anchor.x = Math.sin( @.angle ) * 14
			@.anchor.z = Math.cos( @.angle ) * 14

		updatePosition: ->

			# vertices the camera can move on
			vertices = [ "x" , "y" , "z" ]

			for vertex in vertices

				# handle positioning the camera
				@.alpha.position[ vertex ] = @.ease( @.alpha.position[ vertex ] , @.position[ vertex ] , 0.1 )

			# get the target
			if site.stage.test?.dogs[0]?.mesh?

				 @.facing = site.stage.test.dogs[0]?.mesh?.position

			# make the camera look at its target
			@.alpha.lookAt x: @.facing.x , y: @.facing.y , z: @.facing.z

		ease: ( prop , target , rate ) ->

			# get the difference
			diff = prop - target

			# ease to its new position 
			if Math.abs( diff ) > rate / 10000
				prop -= diff * rate

			# don't kill the memory
			else
				prop = target

			return prop
