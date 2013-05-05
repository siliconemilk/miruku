#to add 'beforeOpen' event to jquery ui dialogs 
`(function ($) {
    $.ui.dialog.prototype.open = function (event){ 
        var that = this;
        if(false === this._trigger('beforeOpen', event)){
            return;
        }
        if ( this._isOpen ) {
            if ( this._moveToTop() ) {
                this._focusTabbable();
            }
            return;
        }
            
        this._isOpen = true;
        this.opener = $( this.document[0].activeElement );

        this._size();
        this._position();
        this._createOverlay();
        this._moveToTop( null, true );
        this._show( this.uiDialog, this.options.show, function() {
            that._focusTabbable();
            that._trigger("focus");
        });

        this._trigger("open");
        }
})(jQuery);`

$ ->

    window.dialogFactory = new DialogFactory()
    window.dialogFactory.register("editMenu", editMenuDialog())
    #window.dialogFactory.register("mainMenu", mainMenuDialog())
    #window.dialogFactory.show("mainMenu")
    $("#clickme").one("click", () -> initEdit() )
    $("#showMenu").on("click", () -> 
        window.dialogFactory.show("mainMenu")
        )
    $('#derp').button()
    #$(document).on("dialogcreate", readyEdit)