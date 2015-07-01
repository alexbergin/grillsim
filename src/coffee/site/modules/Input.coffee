define ->

	class Input

		init: ->

			@.getElements()
			@.addListeners()

		getElements: ->

		addListeners: ->

			actions = [ "mousedown" , "mouseup" , "mousemove" ]
			for action in actions
				window.addEventListener action , @[ "on#{action}" ]?

		onmousedown: ( e ) =>

		onmouseup: ( e ) =>

		onmousemove: ( e ) =>

			if @.gplane and @.mouseConstraint
				
				pos = projectOntoPlane e.clientX , e.clientY , gplane , camera
				
				if pos
					@.setClickMarker pos.x , pos.y , pos.z , scene
					@.moveJointToPoint pos.x , pos.y , pos.z