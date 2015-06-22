define [

	"site/modules/objects/Obj"

] , (

	Obj

) ->

	class HotDog extends Obj

		definition: 
			src: "models/hotdog.obj"
			mass: 1.0
			color: 0xCD692E