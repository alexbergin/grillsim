define ->

	class Obj

		constructor: ( data ) ->

			run = [ "init" , "addGeometry" , "addPhysics" ]
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
			material = new THREE.MeshPhongMaterial
				shading: THREE.SmoothShading
				color: def.color
				specular: 0xFFFFFF
				shininess: 0.3

			# add the material to the object
			@.mesh.material = material
			@.mesh.material.needsUpdate = true

		addPhysics: ->

			# get the object data
			def = @.definition

			if @.mesh?

				p = @.mesh.position

				@.body = new CANNON.Body 
					mass: def.mass
					shape: new CANNON.Box( new CANNON.Vec3(0.5,0.1,3))
					position: new CANNON.Vec3( p.x , p.y , p.z )

				site.stage.world.add @.body

			else
				setTimeout =>
					@.addPhysics()
				, 10

		update: ->

			if @.body? and @.mesh?
				
				vectors = [ "position" , "quaternion" ]
				props = [ "x" , "y" , "z" , "w" ]
				for vector in vectors
					for prop in props
						if @.mesh[vector][ prop ]? then @.mesh[vector][ prop ] = @.body[vector][ prop ]