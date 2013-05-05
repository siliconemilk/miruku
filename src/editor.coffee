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

alignToolWithTarget = (target) ->
    parent = $(target).parent()
    hidden = $(parent).is(":hidden")

    if hidden
        $(parent).show()

    for editable in $(target).find('.editable')
            #lets get kludgey

        width = $(editable).outerWidth()
        offset = {}
        offset.left = (width + $(editable).offset().left)
        offset.top = $(editable).offset().top

        $(editable).next().offset(offset)

    if hidden and parent?
        $(parent).hide()

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
    #dialog creation
    #$('.ui-dialog').on('dialogcreate', (event, ui) -> enableEdit(event.target))
    $(document).on('dialogopen', (event, ui) -> alignToolWithTarget(event.target))
    $(document).on('dialogbeforeopen', (event, ui) -> enableEdit(event.target))
    #$(document).on('dialogclose', (event, ui) -> window.dialogFactory.unregister("mainMenu"))

    #tool creation
    $(document).on('click', '.tool', () -> window.dialogFactory.show("editMenu"))

    enableEdit(document)

    editButton = $("#clickme")
    editButton.text("DISABLE EDITING")
    editButton.one("click", () -> deinitEdit())
    

deinitEdit = () ->
    window.editing = false
    disableEdit(document)

    $(document).off('dialogopen')
    $(document).off('dialogbeforeopen')

    $(document).off("click", ".tool")

    editButton = $("#clickme")
    editButton.text("ENABLE EDITING")
    editButton.one("click", () -> initEdit())
    

enableEdit = (target) -> 
    if window.editing and not $(target).find('.editable').is('.editing')

        $(target).find('.editable').after('<button class="tool"></button>')

        tool = $('.tool')
        tool.button({
        text: false, 
        icons: { primary: "ui-icon-wrench"}
        })

        alignToolWithTarget(target)

        $(target).find('.editable.draggable-element').draggable({cancel: false, grid: [10, 10], start: disableSubmitOnClick, drag: followOnDrag})
        $(target).find('.editable').addClass("editing")
            

disableEdit = (target) -> 
    if not window.editing and $(target).find('.editable').is('.editing')
        $('.tool').remove()
        $('.editable.ui-draggable').draggable("destroy")
        $('.editable').removeClass("editing")
