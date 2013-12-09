post_organization = (org_handle) ->
    $("#organizations .waiting").show()
    $.post("/organization.do",
        org: org_handle
        , (data) ->
            $("#organizations .alert-success").html("Just followed #{data.followed} users from #{org_handle}")
            $("#organizations .alert-success").show()
        ).fail((xhr, status, error) ->
            data = eval("(" + xhr.responseText + ")");
            $("#organizations .alert-danger").html(data.message)
            $("#organizations .alert-danger").show()
        ).always(->
            $("#organizations .waiting").hide()
        )

$ ->
    $("#friends .button-github").click ->
        $("#friends .waiting").show()
        $.post("/friends.do"
        , (data) ->
            $("#friends .alert-success").html("Just followed #{data.followed}.")
            $("#friends .alert-success").show()
        ).fail((xhr, status, error) ->
            data = eval("(" + xhr.responseText + ")");
            $("#friends .alert-danger").html(data.message)
            $("#friends .alert-danger").show()
        ).always(->
            $("#friends .waiting").hide()
        )
    $("#organizations .button-github").click ->
        org_handle = $(this).data("organization")
        post_organization(org_handle)
    $('#organizations input:text').keypress (e) ->
        if(e.which == 13)
            post_organization($(this).val())
