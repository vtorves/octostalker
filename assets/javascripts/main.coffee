$ ->
    $("#friends .button-github").click ->
        $("#friends .waiting").show()
        $.post("/friends.do"
        , (data) ->
            $("#friends .alert-success").html("Just followed #{data.followed}.")
            $("#friends .alert-success").show()
        ).fail(->
            $("#friends .alert-danger").show()
        ).always(->
            $("#friends .waiting").hide()
        )
    $("#organizations .button-github").click ->
        $("#organizations .waiting").show()
        org_handle = $(this).data("organization")
        $.post("/organization.do",
        org: org_handle
        , (data) ->
            $("#organizations .alert-success").html("Just followed #{data.followed} users from #{org_handle}")
            $("#organizations .alert-success").show()
        ).fail(->
            $("#organizations .alert-danger").show()
        ).always(->
            $("#organizations .waiting").hide()
        )
