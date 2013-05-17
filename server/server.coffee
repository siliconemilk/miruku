elements.allow({
    insert: (userId, doc) ->
        return (userId and Meteor.users.findOne(userId).profile.authLevel == 0)
    
    update: (userId, docs, fields, modifier) -> 
        return Meteor.users.findOne(userId).profile.authLevel == 0
    
    remove: (userId, doc) ->
        return (userId and Meteor.users.findOne(userId).profile.authLevel == 0)
    
    fetch: ['owner']
})

#WARNING THIS SEEMS BROKEN INVESTIGATE TOMORROW
Meteor.users.allow({
    update: (userId, docs, fields, modifier) -> 
        console.log(userId + " " + Meteor.users.findOne(userId).profile.authLevel)
        return Meteor.users.findOne(userId).profile.authLevel == 0
    })
Accounts.onCreateUser((options,user) -> 
    #0 = administrator
    #1 = editor
    #2 = regular user
    if options.profile?
        user.profile = options.profile
    else 
        user.profile = {}

    user.profile.authLevel = 2

    return user
)

Meteor.publish("userData", () ->
    user = Meteor.users.findOne(this.userId)
    if user? and user.profile.authLevel == 0
        return Meteor.users.find({}, {fields: {'profile': 1}})
    else 
        return Meteor.users.find({_id: this.userId}, {fields: {'profile': 1}})
)

Meteor.publish("elements", () -> 
    return elements.find()
)