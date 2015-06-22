define ->

	# sets the level lighting
	class Light

		# light options
		cast: true
		color: 0xffffff
		background: 0xafacaa
		onlyShadow: false
		shadowDarkness: 0.05
		debug: false
		mapSize: 4096

		init: ->

			@.make()
			@.preferences()
			@.place()

		make: ->

			# make the lights
			@.light = new THREE.DirectionalLight @.color , 0.2
			@.ambient = new THREE.HemisphereLight @.color , @.background , 0.75

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
			@.light.position.set -30 , 30 , 30
			@.light.lookAt x: 0 , y: 0 , z: 0