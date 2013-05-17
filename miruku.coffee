if Meteor.isClient
    Meteor.autosubscribe(()->
        Meteor.subscribe("userData")
        Meteor.subscribe("elements")
    )

    Meteor.startup(()->
        $(document).on('change', '.auth-level-select', (event, ui) -> updateUser(event.target))
    )
    @buttonColor = "#" + Random.hexString(6)

#admin panel template for editing DOM
    Template.adminPanel.loading = () -> 
        if Meteor.users.find().count() is 0 and Meteor.user()?
            return "Loading..."
        else if Meteor.users.find().count() is 0
            return ""
        else
            return ""

    Template.adminPanel.isAdmin = () -> 
        user =  Meteor.users.findOne(Meteor.userId)
        if user
            return user.profile.authLevel is 0

    Template.adminPanel.isEditor = () ->
        user = Meteor.users.findOne(Meteor.userId)
        if user
            return user.profile.authLevel <= 1

    Template.adminPanel.events = 
        'click #user-management-button' : () -> 
            manageUsers()
        'click #db-management' : () -> 
            manageDB()
        'click #editor' : () -> 
            enableEdit()

    Template.manageUsers.user = () -> 
        return Meteor.users.find()

    Template.dialogs.events = 
        'click #showDialog' : () ->
            createDialog("button", buttonColor)

    Template.DOM.element = () ->
        return elements.find()
        
