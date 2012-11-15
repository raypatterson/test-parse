_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_model = undefined

$_coverContainer = undefined
$_contentContainer = undefined
$_closeButton = undefined
$_nextButton = undefined
$_prevButton = undefined

_navigate = ( id ) -> 
  @log id
  route = if id then _NS.Config.routes.getFeature id else ''
  @ROUTER.navigate route, { trigger : true }
  @

_close = -> 
  _navigate.call @
  @

_next = -> 
  id = _model.getNextItemId()
  _navigate.call @, id
  @

_prev = -> 
  id = _model.getPrevItemId()
  _navigate.call @, id
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

    _model = _MODELS.mainModel.get 'overlayModel'

    $_coverContainer = $ '#overlay-cover'
    $_contentContainer = $ '#overlay-container'

    $_closeButton = $ '#overlay-close-button'
    $_nextButton = $ '#overlay-next-button'
    $_prevButton = $ '#overlay-prev-button'

    @

  addEvents : ->

    super

    _model.on 'change:activeItem', ( model ) =>

      data = _feedModel.get 'activeItem'
      @log 'update view -->', data

      if data
        @render data.toJSON()
        @show 250
      else
        @hide 125

      @

    $_coverContainer.on 'click', ( event ) => _close.call @
    $_closeButton.on 'click', ( event ) => _close.call @
    $_nextButton.on 'click', ( event ) => _next.call @
    $_prevButton.on 'click', ( event ) => _prev.call @

    @

  render : ( data ) ->

    html = undefined
    
    @
    
  resize : ( w, h ) ->
    @log "width: #{w}, height: #{h}"
    
    @$el.css 'height', h
    $_coverContainer.css 'height', h
    
  @