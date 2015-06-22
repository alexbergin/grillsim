"use strict"

require.config
	baseUrl: "/scripts"

	paths:
		"CANNON": "vendor/cannon/build/cannon.min"
		"classlist": "vendor/classlist/classList"
		"requestAnimationFrame": "vendor/requestAnimationFrame/app/requestAnimationFrame"
		"THREE": "vendor/threejs/build/three.min"
		"OBJLoader": "vendor/threejs/examples/js/loaders/OBJLoader"

	shim:
		"OBJLoader":
			deps: [ "THREE" ]

		"THREE":
			deps: [ "CANNON" ]
		
require [ "site/boot" ] , ( Site ) ->
	new Site()