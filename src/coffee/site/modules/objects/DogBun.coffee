define [

	"site/modules/objects/Obj"

] , (

	Obj

) ->

	class DogBun extends Obj

		definition: 
			src: "models/dog-bun.obj"
			mass: 0.3
			color: 0xFEE1B1