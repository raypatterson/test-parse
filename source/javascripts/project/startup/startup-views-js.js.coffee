_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ 'Models' ]
_VIEWS = @__get_project_namespace__ [ 'Views' ]

_log = _NS.log "Views"

_mainModel = undefined
_eventBus = undefined
_eventType = undefined

_initView = (id, View, callback) ->

  _log 'View Init'

  properties = 
    id : id
    el : $ "##{id}"

  new View properties, ->

    _VIEWS[id] = @

    _log '--- View Rendered ---', @, '--- View Rendered ---'
    
    callback()

    @
    
  @


_init = (callback) ->
  
  _log "init"
  
  _mainModel = _MODELS.mainModel
  
  if _NS.Config.touchOS is true then $('body').addClass 'touch'
  
  Nimble.series [
    _initOverlayView
    _initHeaderView
    _initMainView
    _initFooterView
    ], callback
    
  @
  
_initOverlayView = (callback) ->
  _initView 'overlay-view', _VIEWS.OverlayView, callback
  @  
  
_initHeaderView = (callback) ->
  _initView 'header-view', _VIEWS.HeaderView, callback
  @  

_initMainView = (callback) ->
  _log 'Main View'
  _initView 'main-view', _VIEWS.MainView, callback
  @  

_initFooterView = (callback) ->
  _initView 'footer-view', _VIEWS.FooterView, callback
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init