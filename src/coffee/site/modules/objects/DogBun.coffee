define [

	"site/modules/objects/Obj"

] , (

	Obj

) ->

	class DogBun extends Obj

		definition: 
			src: "models/dog-bun.obj"
			mass: 0.1
			color: 0xFEE1B1
			angularDamping: 0.150
			linearDamping:  0.075
			material:
				friction: 0.35

		collision: ->

			# get the object data
			def = @.definition
			p = @.mesh.position

			@.body = new CANNON.Body 
				mass: def.mass
				material: def.material
				angularVelocity: new CANNON.Quaternion Math.random()*-0.5, Math.random()*-0.5, Math.random()*-0.5, Math.random()*-0.5
				angularDamping: def.angularDamping
				linearDamping: def.linearDamping

			vertices = [ "x" , "y" , "z" ]
			for vertex in vertices
				@.body.position[vertex] = @.mesh.position[vertex]

			parts = []

			length = 2.500
			height = 0.700
			depth  = 0.250

			parts.push
				shape: new CANNON.Box new CANNON.Vec3 depth , height , length / 2
				offset: new CANNON.Vec3 -depth * 2.5 , 0 , length / 1.75
				quaternion: new CANNON.Quaternion 0.95372 , 0.30071 , -0.0416 , 0.01312

			parts.push
				shape: new CANNON.Box new CANNON.Vec3 depth , height , length / 2
				offset: new CANNON.Vec3 depth * 2.5 , 0 , length / 1.75
				quaternion: new CANNON.Quaternion 0.95372 , -0.30071 , 0.0416 , -0.01312

			parts.push
				shape: new CANNON.Box new CANNON.Vec3 depth , height , length / 2
				offset: new CANNON.Vec3 -depth * 2.5 , 0 , -length / 1.75
				quaternion: new CANNON.Quaternion 0.95372 , 0.30071 , 0.0416 , -0.01312

			parts.push
				shape: new CANNON.Box new CANNON.Vec3 depth , height , length / 2
				offset: new CANNON.Vec3 depth * 2.5 , 0 , -length / 1.75
				quaternion: new CANNON.Quaternion 0.95372 , -0.30071 , -0.0416 , 0.01312

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

			site.stage.world.add @.body