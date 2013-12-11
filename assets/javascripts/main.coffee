class Scripts

	constructor: ->
		@followAllFriends()
		@followAllInOrgs()
		@searchOrgFollow()

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

					error: ->
						loading.hide()
						msg.addClass("error").find("p").text "Error my friend, try again!"
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000

			e.preventDefault()

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
					fail: (xhr, status, error) ->
						data = eval("(" + xhr.responseText + ")");
						loading.hide()
						msg.addClass("error").find("p").text data.message
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000

			e.preventDefault()

	searchOrgFollow: ->
		classe = @
		$("#orgForm").on "submit", (e) ->
			input = $("#orgSearch")
			loading = $(".loading")
			msg = $("#msg")
			if input.val() isnt "" and not loading.is(":visible")
				loading.slideToggle()
				$.ajax
                    url: "/organization/#{input.val()}"
                    type: "GET"
                    success: (data)->
                        loading.hide()
                        $(data).insertAfter("#follow-everyone .inner .title")
                        @followAllInOrgs()
					fail: (xhr, status, error) ->
						data = eval("(" + xhr.responseText + ")");
						loading.hide()
						msg.addClass("error").find("p").text data.message
						msg.slideToggle()
						setTimeout (->
							msg.slideToggle()
						), 6000

			e.preventDefault()

$(document).ready ->
	new Scripts()
