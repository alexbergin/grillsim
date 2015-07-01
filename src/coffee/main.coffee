"use strict"

require.config
	baseUrl: "/scripts"

	paths:
		"CANNON": "vendor/cannon/build/cannon.min"
		"classlist": "vendor/classlist/classList"
		"requestAnimationFrame": "vendor/requestAnimationFrame/app/requestAnimationFrame"
		"THREE": "vendor/threejs/build/three.min"
		"OBJLoader": "vendor/threejs/examples/js/loaders/OBJLoader"
		"CannonDebugRenderer": "vendor/cannon/tools/threejs/CannonDebugRenderer"

	shim:
		"OBJLoader":
			deps: [ "THREE" ]

		"THREE":
			deps: [ "CANNON" ]

		"CannonDebugRenderer":
			deps: [ "CANNON" , "THREE" ]
		
require [ "site/boot" ] , ( Site ) ->
	new Site()