#prevents triggering of submit action on button immediately after dragging
#buttons will automatically remove noclick class after a successful drag
disableSubmitOnClick = (event, ui) ->
    $(this).addClass('noclick')
    return

followOnDrag = (event, ui) ->
    width = $(this).outerWidth()
    offset = {}
    offset.left = (width + ui.offset.left)
    offset.top = ui.offset.top

    $(this).next().offset(offset)

readyEdit = (event, ui) ->
    if window.editing
        enableEdit()

unreadyEdit = (event, ui) ->

#INIT EDIT -> editing is true, register for open/close/create/click events as appropriate 

#ENABLE EDIT -> if editing is true, find all editable and append tool. 
#       Open Event -> append tool to editables in container, add click event to tool
#       Close Event -> remove tool from editables in container, remove click event from tool
#       Create Event ->  

#DISABLE EDIT -> remove all tool objects in container
#       Be sure to remove any handlers attached to any editable elements in container

#DEINIT EDIT -> Remove all tool objects in document, release all event handlers which we assigned in init edit

initEdit = () ->
#register event handlers
    window.editing = true
    enableEdit(document)
    #dialog creation
    $(document).on('dialogcreate', (event, ui) -> enableEdit(event.target))
    $(document).on('dialogopen', (event, ui) -> enableEdit(event.target))
    $(document).on('dialogclose', (event, ui) -> disableEdit(event.target))
    #tool creation
    $(document).on('click', '.tool', () -> window.dialogFactory.show("editMenu"))

    editButton = $("#clickme")
    editButton.text("DISABLE EDITING")
    editButton.one("click", () -> deinitEdit())
    

deinitEdit = () ->
    window.editing = false
    disableEdit(document)
    $(document).off('dialogcreate')
    $(document).off('dialogopen')
    $(document).off('dialogclose')

    $(document).off('click')

    editButton = $("#clickme")
    editButton.text("ENABLE EDITING")
    editButton.one("click", () -> initEdit())
    

enableEdit = (target) -> 
    if window.editing and not $(target).find('.editable').is('.editing')
        $(target).find('.editable').after('<button class="tool"/>')
        tool = $('.tool')
        tool.button({
            text: false, 
            icons: { primary: "ui-icon-wrench"}
            })

        olderSibling = tool.prev()
        #tool.offset({left: olderSibling.outerWidth() + olderSibling.offset().left, top: olderSibling.offset().top})
        
        $(target).find('.editable.draggable-element').draggable({cancel: false, grid: [10, 10], start: disableSubmitOnClick, drag: followOnDrag})
        $(target).find('.editable').addClass("editing")

disableEdit = (target) -> 
    if not window.editing and $(target).find('.editable').is('.editing')
        $('.tool').remove()
        $('.editable.ui-draggable').draggable("destroy")
        $('.editable').removeClass("editing")

#ifdef DEBUG
magicEdit = () ->
    #$('.editable').after('<button class="tool"><img src="./content/cog_alt_16x16.png"></img></button>')
    $('.editable').after('<button class="tool"/>')
    $('.tool').button({
        text: false,
        icons: { primary: "ui-icon-wrench"}
        })

    elements = document.body.getElementsByTagName("*")

    for item in elements
        if $(item).hasClass("editable")
  
            classes = $(item).classes()

            $(item).next().offset({left: $(item).outerWidth() + $(item).offset().left, top: $(item).offset().top})

            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        #if not initialized yet, we can safely initializle
                        if $.inArray("ui-draggable", classes) < 0
                            $(item).draggable({cancel: false, grid: [10,10], start: disableSubmitOnClick, drag: followOnDrag})


    editButton = $("#clickme")
    editButton.text("DISABLE EDITING")
    editButton.one("click", disableEdit)

    window.editing = true

    
dopeEdit = () ->
    $('.tool').remove()

    elements = document.body.getElementsByTagName("*")
    
    for item in elements
        if $(item).hasClass("editable")
            classes = $(item).classes()

            for itemClass in classes
                switch itemClass
                    when "draggable-element"
                        #check to make sure the draggable element has actually been initialized as a draggable
                        if $.inArray("ui-draggable", classes) > -1
                            $(item).draggable("option", "cancel", "input, textarea, button, select, option")

    editButton = $("#clickme")
    editButton.text("ENABLE EDITING")
    editButton.one('click', enableEdit)

    window.editiing = false
#endif