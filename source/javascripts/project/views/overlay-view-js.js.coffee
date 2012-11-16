_VIEWS = @__get_project_namespace__ [ "Views" ]

_model = undefined

$_contentContainer = undefined
$_coverContainer = undefined
$_closeButton = undefined

_close = -> 
  _navigate.call @
  @


class _VIEWS.OverlayView extends _VIEWS.BaseView

  className : 'OverlayView'

  initialize : ( properties, @onReady ) ->
    
    super properties, @onReady

    @log 'init'

    @ready()

    @


  addProperties : ->

    super

    _model = @MODELS.mainModel
    # _model = @MODELS.mainModel.get 'overlayModel'

    $_contentContainer = $ 'overlay-content-container'
    $_coverContainer = $ 'overlay-cover-container'
    $_closeButton = $ 'overlay-close-button'

    @

  addEvents : ->

    super

    _model.on 'change:activeItem', ( model ) =>

      viewModel = _model.get 'activeItem'
      @log 'update view -->', viewModel

      if viewModel
        @render viewModel.toJSON()
        @show 250
      else
        @hide 125

      @

    $_coverContainer.on 'click', ( event ) => _close.call @
    $_closeButton.on 'click', ( event ) => _close.call @

    @

  render : ( data ) ->

    html = undefined
    
    @
    
  resize : ( w, h ) ->
    @log "width: #{w}, height: #{h}"
    
    @$el.css 'height', h
    $_coverContainer.css 'height', h
    
  @