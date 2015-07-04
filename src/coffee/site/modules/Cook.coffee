define ->

	class Cook

		cooking: []
		last: 0

		maxAltitude: 	0.7500
		maxCooked: 		0.0025

		add: ( item ) ->

			@.cooking.push item

		init: ->

			@.last = new Date().getTime()

		loop: ->

			now = new Date().getTime()
			if now - @.last >= 250
				@.last = now

				for item in @.cooking

					if item.mesh? then for face in item.mesh.geometry.faces

						altitude = @.getPosition item , face
						cookedAmount = @.getCooked altitude
						@.applyColor item , face , cookedAmount

		getPosition: ( item , face ) ->

			vector = face.normal.clone()
			vector.applyMatrix4 item.mesh.matrixWorld
			return vector.y

		getCooked: ( altitude ) ->

			cooked = Math.max( @.maxAltitude * @.maxAltitude - altitude * altitude , 0 )
			cooked = cooked / ( @.maxAltitude * @.maxAltitude )
			cooked *= @.maxCooked
			return cooked

		applyColor: ( item , face , cookedAmount ) ->

			if face.cooked?
				face.cooked -= cookedAmount
				face.cooked = Math.max face.cooked , 0.2
			else
				face.cooked = 1

			c = face.cooked
			face.color.setRGB c , c ,c 
			item.mesh.geometry.colorsNeedUpdate = true
