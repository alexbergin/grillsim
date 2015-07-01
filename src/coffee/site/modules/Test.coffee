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

			window.addEventListener "touchstart" , @.make
			@.make()

		make: =>

			@.dogs.push new HotDog
				position:
					y: 9
			@.buns.push new DogBun
				position:
					y: 6

		loop: ->

			for dog in @.dogs
				dog.update()

			for bun in @.buns
				bun.update()