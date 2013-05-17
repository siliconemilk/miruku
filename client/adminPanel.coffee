@manageUsers = () -> 
    $('body').append("<div id=\"user-management\">" + Template.manageUsers() + "</div>")
    $("#user-management").dialog({
        width: 'auto',
        title: 'User Management',
        autoOpen: false
    })

    $('.user-row').each(()->
        options = $(this).find('option')
        id = $(this).attr('id')

        if id is Meteor.userId()
            #dont want to edit own user account. Do we even bother displaying it?
            $(this).find('select').attr("disabled", "disabled")
            #$(this).addClass("userIsMe")
        else
            console.log(id + " " + Meteor.userId)

        for option, i in options
            if Meteor.users.findOne({_id: id}).profile.authLevel == i
                $(option).attr("selected", "selected")
    )

    $('#user-management').dialog("open")

@updateUser = (target) -> 
    id = $(target).closest('.user-row').attr("id")
    authLevel = $(target).find('option:selected').attr("value")
    #console.log(authLevel)
    Meteor.users.update({_id: id}, {$set: {'profile.authLevel': parseInt(authLevel)}})

@manageDB = () -> 
    console.log("manage database")
