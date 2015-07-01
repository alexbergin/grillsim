define ->

	# sets the level lighting
	class Light

		# light options
		cast: true
		color: 0xffffff
		background: 0xEDFFFE
		onlyShadow: false
		shadowDarkness: 0.1
		debug: false
		mapSize: 800

		init: ->

			@.make()
			@.preferences()
			@.place()

		make: ->

			# make the lights
			@.light = new THREE.DirectionalLight @.background , 0.1
			@.ambient = new THREE.HemisphereLight @.background , @.background , 0.75

		preferences: ->

			# set preferences
			@.light.castShadow = @.cast
			@.light.onlyShadow = @.onlyShadow

			# shadows
			@.light.shadowDarkness = @.shadowDarkness
			@.light.shadowCameraVisible = @.debug
			@.light.shadowCameraNear = 0
			@.light.shadowCameraFar = 75
			@.light.shadowCameraLeft = -25
			@.light.shadowCameraRight = 25
			@.light.shadowCameraTop = 25
			@.light.shadowCameraBottom = -25
			@.light.shadowMapWidth = @.mapSize
			@.light.shadowMapHeight = @.mapSize

		place: ->

			# put the lights on the stage
			site.stage.scene.add @.light
			site.stage.scene.add @.ambient

			# position the light source
			@.light.position.set -10 , 30 , 10
			@.light.lookAt x: 0 , y: 0 , z: 0