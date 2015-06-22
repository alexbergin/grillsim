define ->

	class World

		init: ->

			@.setup()

		setup: ->

			# make the world if it doesn't already exist
			if @.w is undefined then @.w = new CANNON.World()

			# preferences
			@.w.broadphase = new CANNON.NaiveBroadphase()
			@.w.gravity.set( 0 , -9.81 , 0 )
			@.w.solver.tolerance = 0.001

			# make a ground plane for now
			plane = new CANNON.Body
				mass: 0
				shape: new CANNON.Plane()
				position: new CANNON.Vec3( 0 , -10 , 0 )
			plane.quaternion.setFromAxisAngle(new CANNON.Vec3(1,0,0),-Math.PI/2)
			@.add plane

			# define geometry & material
			geometry = new THREE.PlaneGeometry 300 , 300 , 1 , 1
			material = new THREE.MeshBasicMaterial
				color: 0xf1fDfC

			# make a new mesh
			landscape = new THREE.Mesh geometry , material
			landscape.receiveShadow = true

			# position
			landscape.position.x = 0
			landscape.position.y = -10.5
			landscape.position.z = 0
			landscape.rotation.x = Math.radians( -90 )

			# save to class
			@.ground = landscape

			# add to the stage
			site.stage.scene.add @.ground

		loop: ( delta ) ->

			@.w.step 1/60 , delta , 3

		add: ( data ) ->

			@.w.addBody data

		remove: ( data ) ->

			@.w.removeBody data