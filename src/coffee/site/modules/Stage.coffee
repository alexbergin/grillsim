define [

	# submodules
	"site/modules/Camera"
	"site/modules/Light"
	"site/modules/World"
	"site/modules/Test"

] , (

	# submodules
	Camera
	Light
	World
	Test

) ->

	class Stage

		# controls what gets done in the render task
		looping: true

		# scale the canvas based on touch ability
		isTouch: false

		# what modules to call .init() on
		setupTasks: [
			"light"
			"camera"
			"world"
			"test"
		]

		# what modules to call .loop() on
		loopTasks: [
			"camera"
			"world"
			"test"
		]

		# submodules
		camera: new Camera
		light: new Light
		world: new World
		test: new Test

		# used to calc time delta
		present: 0

		init: ->

			# setup
			@.getElements()
			@.addListeners()
			@.build()
			@.onResize()
			@.render()

		getElements: ->

			# save the page element for later
			@.page = document.getElementsByTagName( "main" )[0]
			@.present = Date.now()

		addListeners: ->

			# resize the renderer to always match the window
			window.addEventListener "resize" , @.onResize

		build: ->

			# create the THREE elements
			@.scene = new THREE.Scene()
			@.renderer = new THREE.WebGLRenderer

			# set renderer preferences
			@.renderer.setClearColor 0xFFFBED
			@.onIsTouch()

			# no shadows when mobile
			if @.isTouch is 1000
				@.renderer.shadowMapEnabled = false
			else 
				@.renderer.shadowMapEnabled = true
				@.renderer.shadowMapType = THREE.PCFShadowMap

			# append to the page
			@.renderer.domElement.classList.add "stage"
			@.page.appendChild @.renderer.domElement

			# setup sub modules
			for task in @.setupTasks
				@[task].init?()

		onResize: =>

			# set canvas scale
			if @.isTouch is true then mult = 2 else mult = 1

			# get the width + height
			@.height = window.innerHeight * mult
			@.width = window.innerWidth * mult

			# resize the renderer
			@.renderer.setSize @.width , @.height

		onIsTouch: =>

			# test
			if window.ontouchstart isnt undefined

				# apply styles specific for touch devices
				document.body.classList.add "is-touch"

				# save the state for later
				@.isTouch = true

				# apply a resize
				@.onResize()

		render: =>

			# call this to check loop again
			requestAnimationFrame @.render

			# get the time passed
			past = @.present
			delta = @.present - past
			@.present = Date.now()

			# test to see if loop should be performed
			if @.looping

				# run the loop function on each task
				for task in @.loopTasks
					site.stage[ task ].loop? delta

			# render the scene to the canvas
			@.renderer.render @.scene , @.camera.alpha