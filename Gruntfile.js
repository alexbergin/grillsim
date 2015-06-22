"use strict"; 

module.exports = function( grunt ) {

	// Useful for showing time taken for Grunt tasks
	require("time-grunt")(grunt);

	// Automatically load libraries for Grunt tasks
	require("load-grunt-tasks")(grunt);

	grunt.initConfig({

		autoprefixer: {
			app: {
				expand: true,
				flatten: true,
				src: "app/styles/*.css",
				dest: "app/styles/"
			}
		},

		browserSync: {
			bsFiles: [
				"app/scripts/site/**",
				"app/styles/*.css",
				"app/*.html"
			],
			options: {
				watchTask: true,
				ghostMode: false,
				server: {
					baseDir: "app"
				}
			}
		},

		coffee: {
			dev: {
				options: {
					bare: true,
					sourceMap: true
				},
				expand: true,
				cwd: "src/coffee/",
				src: [ "**/*.coffee" ],
				dest: "app/scripts",
				ext: ".js"
			}
		},

		coffeelint: {
			app: {
				files: {
					src: [ "src/coffee/**/*.coffee" ]
				},
				options: {
					"max_line_length": {
						"level": "ignore"
					}
				}
			}
		},

		compass: {
			dev: {
				options: {
					sassDir: "src/sass",
					extensionsDir: "src/sass/extensions",
					cssDir: "app/styles",
					imagesDir: "app/images",
					relativeAssets: true,
					force: true
				}
			}
		},

		concat: {
			options: {
				stripBanners: true
			},
			home: {
				src: [ "app/scripts/site.js" ],
				dest: "app/scripts/site.js"
			}
		},

		copy: {
			npm: {
				expand: true,
				cwd: "node_modules",
				src: [
					"cannon/**"
				],
				dest: "app/scripts/vendor"
			},
			app: {
				expand: true,
				cwd: "src/",
				src: [
					"images/**",
					"models/**"
				],
				dest: "app"
			},
			dist: {
				expand: true,
				cwd: "app/",
				src: [
					"images/**",
					"models/**",
					"styles/**"
				],
				dest: "dist"
			}
		},

		cssmin: {
			dist: {
				files: {
					"dist/styles/main.css": [ "dist/styles/main.css" ]
				}
			}
		},

		htmlmin: {
			dist: {
				options: {
					collapseWhitespace: true,
					minifyJS: true,
					minifyCSS: true
				},
				files: {
					"dist/index.html": "app/index.html"
				}
			}
		},

		"html-prettyprinter": {
			main: {
				src: "app/index.html",
				dest: "app/index.html"
			}
		},

		mustache_render: {
			options: {
				directory: "src/mustache"
			},
			build: {
				data: "src/json/main.json",
				template: "src/mustache/main.mustache",
				dest: "app/index.html"
			}
		},

		requirejs: {
			dist: {
				options: {
					baseUrl: "app/scripts",
					name: "main",
					include: [ "vendor/requirejs/require" , "vendor/cannon/build/cannon" ],
					findNestedDependencies: true,
					optimize : "uglify",
					out: "dist/scripts/main.js",
					mainConfigFile: "app/scripts/main.js"
				}
			}
		},

		targethtml: {
			dev: {
				files: {
					"app/index.html": "app/index.html"
				}
			},
			dist: {
				files: {
					"dist/index.html": "dist/index.html"
				}
			}
		},

		watch: {
			compass: {
				files: [ "src/sass/**" ],
				tasks: [ "compass" , "autoprefixer" ],
				options: {
					debounceDelay: 200
				}
			},
			coffee: {
				files: [ "src/coffee/**" , "src/models/**" ],
				tasks: "coffee",
				options: {
					debounceDelay: 200
				}
			},
			mustache: {
				files: [ "src/mustache/**" ],
				tasks: ["mustache_render","targethtml:dev","html-prettyprinter"],
				options: {
					debounceDelay: 200
				}
			},
			json: {
				files: [ "src/json/**" ],
				tasks: ["mustache_render","targethtml:dev","html-prettyprinter"],
				options: {
					debounceDelay: 200
				}
			}
		}

	});

	// Build
	grunt.registerTask( "build", [
		"mustache_render",
		"html-prettyprinter",
		"compass",
		"autoprefixer:app",
		"coffee:dev",
		"copy:app",
		"copy:npm",
		"copy:dist",
		"cssmin",
		"htmlmin",
		"requirejs",
		"targethtml"
	]);

	// run to compress new images
	grunt.registerTask( "compress" , [ "imagemin" ]);

	// Prep the dev environment for watching, or run this directly to
	// update it a single time
	grunt.registerTask( "devupdate", [
		"copy:app",
		"copy:npm",
		"compass",
		"autoprefixer:app",
		"coffee:dev",
		"mustache_render",
		"html-prettyprinter",
		"targethtml"
	]);

	// Update dev environment, and start watch
	grunt.registerTask( "start", [
		"devupdate",
		"browserSync",
		"watch"
	]);

	grunt.registerTask( "default", [ "build" ] );
};