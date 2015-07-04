define ->

	class Obj

		constructor: ( data ) ->

			run = [ "init" , "addGeometry" ]
			for process in run
				@[ process ]? data

		addGeometry: ( data ) ->

			# get the object data
			def = @.definition
			
			# load the mesh
			loader = new THREE.OBJLoader()
			loader.load def.src , ( obj ) => 
				@.geometryLoaded obj , data

		geometryLoaded: ( obj , data ) ->
			
			# save the object
			@.obj = obj
			@.mesh = @.obj.children[0]

			# convert from buffer geometry to regular
			# consider doing this only when a vertex needs editing?
			@.mesh.geometry = new THREE.Geometry().fromBufferGeometry @.mesh.geometry

			# set up shadows
			@.mesh.castShadow = true
			@.mesh.receiveShadow = true

			# set up the position/rotation/scale data
			defaults =
				position:
					x: 0 , y: 0 , z: 0
				rotation:
					x: 0 , y: 0 , z: 0
				scale:
					x: 1 , y: 1 , z: 1

			# loop through and apply data if provided
			run = [ "position" , "rotation" , "scale" ]
			vertices = [ "x" , "y" , "z" ]

			# update the positioning
			for process in run
				for vertex in vertices
					if data?[ process ]?[ vertex ]?
						defaults[ process ][ vertex ] = data[ process ][ vertex ]
					@.mesh[ process ][ vertex ] = defaults[ process ][ vertex ]

			# add it to the scene
			site.stage.scene.add @.obj

			run = [ "addMaterial" , "addPhysics" ]
			for process in run
				@[ process ]? data

		addMaterial: ->

			# get the object data
			def = @.definition

			# basic material for cruise control to simplicity
			material = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: def.color
				specular: 0xFFFFFF
				shininess: 0.3

			# add the material to the object
			@.mesh.material = material
			@.mesh.material.needsUpdate = true

		addPhysics: ->

			if @.mesh?
				@.collision?() 
			else
				setTimeout =>
					@.addPhysics()
				, 10

		update: ->

			# sync the positioning of the threejs object with the cannon object
			if @.body? and @.mesh?
				
				# vectors/props we loop through
				vectors = [ "position" , "quaternion" ]
				props = [ "x" , "y" , "z" , "w" ]
				
				for vector in vectors
					for prop in props

						# three value = cannon values=
						if @.mesh[vector][ prop ]? then @.mesh[vector][ prop ] = @.body[vector][ prop ]