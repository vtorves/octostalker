class Scripts

	constructor: ->
		#@hoverFriends()
		@followAllFriends()
		#@followOneFriend()
		#@hoverOrgs()
		#@followOneInOrg()
		@followAllInOrgs()
		@searchOrgFollow()
		#@searchOrg()
		#@toolsTip()

	# toolsTip: ->
	# 	$('#friends').find('a').tooltip({'placement': 'bottom'});
	# 	$('.members').find('li a').tooltip({'placement': 'bottom'});
	# 	return

	# hoverFriends: ->
	# 	$("#friends").find("a").on("mouseenter", ->
	# 		span = $(this).find("span")
	# 		if span.hasClass("follow")
	# 			span.addClass "no"
	# 		else
	# 			span.addClass "yes"
	# 		return
	# 	).on "mouseleave", ->
	# 		span = $(this).find("span")
	# 		if span.hasClass("follow")
	# 			span.removeClass "no"
	# 		else
	# 			span.removeClass("no").removeClass "yes"
	# 		return
	# 	return

	# followOneFriend: ->
	# 	$("#friends").find("a").on "click", (e) ->
	# 		loading = $(".loading")
	# 		msg = $("#msg")
	# 		t = $(this)
	# 		action = "follow"
	# 		user = t.attr("data-user")
	# 		unless loading.is(":visible")
	# 			loading.slideToggle()
	# 			action = "unfollow"  if t.find("span").hasClass("follow")
	# 			$.ajax
	# 				url: ""
	# 				type: "POST"
	# 				data: {}
	# 				success: ->
	# 					loading.hide()
	# 					msg.addClass("sucess").find("p").text "You now " + action + " @" + user + "!"
	# 					if action is "unfollow"
	# 						t.find("span").removeClass("follow").each ->
	# 							t.attr "data-original-title", "Follow @" + t.attr("data-user")

	# 					else
	# 						t.find("span").addClass("follow").each ->
	# 							t.attr "data-original-title", "Unfollow @" + t.attr("data-user")

	# 					msg.slideToggle()
	# 					setTimeout (->
	# 						msg.slideToggle()
	# 					), 6000
	# 					return

	# 				error: ->
	# 					loading.hide()
	# 					msg.addClass("error").find("p").text "Error my friend, try again!"
	# 					msg.slideToggle()
	# 					setTimeout (->
	# 						msg.slideToggle()
	# 					), 6000
	# 					return

	# 		e.preventDefault()
	# 		return
	# 	return

	followAllFriends: ->
		$("#followAllFriends").on "click", (e) ->
			loading = $(".loading")
			msg = $("#msg")
			unless loading.is(":visible")
				loading.slideToggle()
				$.ajax
					url: "/friends.do"
					type: "POST"
					data: {}
					success: ->
						loading.hide()
						msg.addClass("sucess").find("p").text "Congratz, you follow everyone now!"
						msg.slideToggle()
						$("#friends").find("span").addClass("follow").each ->
							link = $(this).parent()
							link.attr "data-original-title", "Unfollow @" + link.attr("data-user")

						setTimeout (->
							msg.slideToggle()
						), 6000
						return

					error: ->
						loading.hide()
						msg.addClass("error").find("p").text "Error my friend, try again!"
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000
						return

			e.preventDefault()
			return
		return

	# hoverOrgs: ->
	# 	$(".members").find("li a").on("mouseenter", ->
	# 		span = $(this).find("span")
	# 		if span.hasClass("follow")
	# 			span.addClass "no"
	# 		else
	# 			span.addClass "yes"
	# 		return
	# 	).on "mouseleave", ->
	# 		span = $(this).find("span")
	# 		if span.hasClass("follow")
	# 			span.removeClass "no"
	# 		else
	# 			span.removeClass("no").removeClass "yes"
	# 		return
	# 	return

	# followOneInOrg: ->
	# 	$(".members").find("li a").on "click", (e) ->
	# 		loading = $(".loading")
	# 		msg = $("#msg")
	# 		t = $(this)
	# 		action = "follow"
	# 		user = t.attr("data-user")
	# 		unless loading.is(":visible")
	# 			loading.slideToggle()
	# 			action = "unfollow"  if t.find("span").hasClass("follow")
	# 			$.ajax
	# 				url: ""
	# 				type: "POST"
	# 				data: {}
	# 				success: ->
	# 					loading.hide()
	# 					msg.addClass("sucess").find("p").text "You now " + action + " @" + user + "!"
	# 					if action is "unfollow"
	# 						t.find("span").removeClass("follow").each ->
	# 							t.attr "data-original-title", "Follow @" + t.attr("data-user")

	# 					else
	# 						t.find("span").addClass("follow").each ->
	# 							t.attr "data-original-title", "Unfollow @" + t.attr("data-user")

	# 					msg.slideToggle()
	# 					setTimeout (->
	# 						msg.slideToggle()
	# 					), 6000
	# 					return

	# 				error: ->
	# 					loading.hide()
	# 					msg.addClass("error").find("p").text "Error my friend, try again!"
	# 					msg.slideToggle()
	# 					setTimeout (->
	# 						msg.slideToggle()
	# 					), 6000
	# 					return

	# 		e.preventDefault()
	# 		return
	# 	return

	followAllInOrgs: ->
		$(".followorg").on "click", (e) ->
			t = $(this)
			loading = $(".loading")
			msg = $("#msg")
			org = t.attr("data-org")
			unless loading.is(":visible")
				loading.slideToggle()
				$.ajax
					url: "/organization.do"
					type: "POST"
					data:
						org: org
					success: ->
						loading.hide()
						msg.addClass("sucess").find("p").text "Congratz, you follow everyone now!"
						msg.slideToggle()
						t.parent().parent().find("ul span").addClass("follow").each ->
							link = $(this).parent()
							link.attr "data-original-title", "Unfollow @" + link.attr("data-user")

						setTimeout (->
							msg.slideToggle()
						), 6000
						return

					fail: (xhr, status, error) ->
						data = eval("(" + xhr.responseText + ")");
						loading.hide()
						msg.addClass("error").find("p").text data.message
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000
						return

			e.preventDefault()
			return
		return

	searchOrgFollow: ->
		classe = @
		$("#orgForm").on "submit", (e) ->
			input = $("#orgSearch")
			loading = $(".loading")
			msg = $("#msg")
			if input.val() isnt "" and not loading.is(":visible")
				loading.slideToggle()
				$.ajax
					url: "/friends.do"
					type: "POST"
					data:
						org: input.val()

					success: (data) ->
						loading.hide()
						msg.addClass("sucess").find("p").text "Just followed "+data.followed+" users from "+input.val()
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000
						return

					fail: (xhr, status, error) ->
						data = eval("(" + xhr.responseText + ")");
						loading.hide()
						msg.addClass("error").find("p").text data.message
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000
						return

			e.preventDefault()
			return
		return

	# searchOrg:->
	# 	classe = @
	# 	$("#orgForm").on "submit", (e) ->
	# 		input = $("#orgSearch")
	# 		loading = $(".loading")
	# 		msg = $("#msg")
	# 		if input.val() isnt "" and not loading.is(":visible")
	# 			loading.slideToggle()
	# 			$.ajax
	# 				url: ""
	# 				type: "POST"
	# 				data:
	# 					orgName: input.val()

	# 				success: (data) ->
	# 					org = JSON and JSON.parse(data) or $.parseJSON(data)
	# 					html = undefined
	# 					loading.hide()
	# 					if org.name is ""
	# 						msg.addClass("error").find("p").text "Sorry man, this organization doesn't exist!"
	# 						msg.slideToggle()
	# 						setTimeout (->
	# 							msg.slideToggle()
	# 						), 6000
	# 						return false
	# 					html = "<div class=\"org-avatar\"><img src=\"" + org.avatar + "\" width=\"240\" height=\"240\" alt=\"\"></div>"
	# 					html += "<div class=\"members\">"
	# 					html += "<h3><span>Members of " + org.name + "</span> <a href=\"http://github.com/" + org.name + "\" class=\"btn followorg\" data=org=\"" + org.name + "\">Follow everyone in " + org.name + "</a></h3><ul>"
	# 					$.each org.members, (index, value) ->
	# 						action = ""
	# 						title = "Follow"
	# 						if org.members[index].isFollowed
	# 							action = "follow"
	# 							title = "Unfollow"
	# 						html += "<li><a href=\"http://github.com/" + org.members[index].user + "\" data-toggle=\"tooltip\" title=\"" + title + " @" + org.members[index].user + "\" data-user=\"" + org.members[index].user + "\"><img src=\"" + org.members[index].avatar + "\" width=\"70\" height=\"70\" alt=\"\"><span class=\"" + action + "\"></span></a></li>"

	# 					html += "</ul></div>"
	# 					$("#searchOrg").html html
	# 					classe.hoverOrgs()
	# 					classe.followOneInOrg()
	# 					classe.followAllInOrgs()
	# 					return

	# 				error: ->
	# 					loading.hide()
	# 					msg.addClass("error").find("p").text "Error my friend, try again!"
	# 					msg.slideToggle()
	# 					setTimeout (->
	# 						msg.slideToggle()
	# 					), 6000
	# 					return

	# 		e.preventDefault()
	# 		return
	# 	return

$(document).ready ->
	new Scripts()
	return
