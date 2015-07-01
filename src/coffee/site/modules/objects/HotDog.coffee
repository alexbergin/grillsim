define [

	"site/modules/objects/Obj"

] , (

	Obj

) ->

	class HotDog extends Obj

		definition: 
			src: "models/hotdog.obj"
			mass: 0.5
			color: 0xCD692E
			angularDamping: 0.01
			linearDamping: 0.01
			material:
				friction: 0.1

		collision: ->

			# get the object data
			def = @.definition
			p = @.mesh.position

			@.body = new CANNON.Body 
				mass: def.mass
				angularVelocity: new CANNON.Quaternion Math.random()*-0.5, Math.random()*-0.5, Math.random()*-0.5, Math.random()*-0.5
				material: def.material
				angularDamping: def.angularDamping
				linearDamping: def.linearDamping

			vertices = [ "x" , "y" , "z" ]
			for vertex in vertices
				@.body.position[vertex] = @.mesh.position[vertex]

			parts = []

			radius = 0.5
			length = 4.85
			shift =  0.55

			parts.push 
				shape: new CANNON.Sphere radius
				offset: new CANNON.Vec3 0 , shift , -length/2

			parts.push
				shape: new CANNON.Sphere radius
				offset: new CANNON.Vec3 0 , shift , length/2

			parts.push
				shape: new CANNON.Sphere radius
				offset: new CANNON.Vec3 0 , -shift * 0.1 , 0

			parts.push
				shape: new CANNON.Cylinder radius * 0.9 , radius * 0.9 , length/4 + radius , 6
				offset: new CANNON.Vec3 0 , shift / 2.125 , -length/4
				quaternion: new CANNON.Quaternion  0.99144 , 0 , 0 , -0.13053

			parts.push
				shape: new CANNON.Cylinder radius * 0.9 , radius * 0.9 , length/4 + radius , 6
				offset: new CANNON.Vec3 0 , shift / 2.125 , length/4
				quaternion: new CANNON.Quaternion  0.99144 , 0 , 0 , 0.13053

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

			site.stage.world.add @.body