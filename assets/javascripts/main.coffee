$ ->
        $("#friends .button-github").click ->
                $.post "/friends.do", (data) ->
                        $(".result").html data


        $("#organizations .button-github").click ->
          org_handle = $(this).data("organization")
          $.post "/organization.do",
            org: org_handle
                , (data) ->
                        alert data
