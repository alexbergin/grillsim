define [

	# modules
	"site/modules/Stage"

	# libs
	"CANNON"
	"requestAnimationFrame"
	"classlist"
	"THREE"

	# plugins
	"OBJLoader"
	"CannonDebugRenderer"

] , (

	# modules
	Stage

	# libs
	CANNON
	requestAnimationFrame
	classlist
	THREE

) ->

	# this is the main start point for the site/game.

	Site = ->

		class App

			stage: new Stage

			start: ->

				# property names to call "init" on
				# when the site is ready to run
				run = [ "stage" ]

				# start all sub classes
				for classes in run
					site[ classes ].init()

		# store everything in the window.site variable
		# and start running all scripts
		window.site = new App
		site.start()