define [

	"site/modules/objects/HotDog"
	"site/modules/objects/DogBun"

] , (

	HotDog
	DogBun

) ->

	class Test

		dogs: []
		buns: []

		init: ->

			@.make()

		make: ->

			@.dogs.push new HotDog
				position: 
					y: 2
				rotation:
					z: 0.1
			@.buns.push new DogBun()

		loop: ->

			for dog in @.dogs
				dog.update()

			for bun in @.buns
				bun.update()